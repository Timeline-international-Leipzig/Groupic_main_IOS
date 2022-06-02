//
//  AddShow.swift
//  Groupic
//
//  Created by Anatolij Travkin on 22.05.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct ShowParticipantView: View {
    var userCollection = Firestore.firestore().collection("events")
    
    @ObservedObject var followService = FollowService()
    
    @State var userSelected: UserModel?
    @State var next = false
    
    @State var user: UserModel
    @State var post: PostModel
    
    @State var show = false
    @State var admin = false
    
    var body: some View {
        VStack {
            if user.uid != post.creatorId && show == false {
                NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                HStack {
                    Button(action: {
                        self.userSelected = user
                        
                        next.toggle()
                    }, label: {
                        HStack {
                            if user.profileImageId == "" {
                                Image("profileImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                            }
                            
                            else {
                                WebImage(url: URL(string: user.profileImageId))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60, alignment: .center)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                            }
                            
                            Text(user.username)
                                .font(.subheadline)
                                .bold()
                            
                            if Auth.auth().currentUser!.uid == post.creatorId || admin == true {
                                VStack {
                                Button(action: {
                                    followService.makeAdminEvent(userId: user.uid, postId: post.id)
                                }, label: {
                                    Text("Zum Admin machen")
                                        .font(.subheadline)
                                        .bold()
                                })
                                    
                                    Button(action: {
                                        followService.deInvite(userId: user.uid, postId: post.id)
                                    }, label: {
                                        Text("Entfernen")
                                            .font(.subheadline)
                                            .bold()
                                    })
                                    .padding(.top)
                                }
                            }
                            else {}
                            
                            Spacer()
                        }
                        .padding()
                    })
                }
            }
            else {}
        }
        .onAppear {
            checkAdminExists(postId: post.id, uid: user.uid) { result in
                if (result == true) {
                    self.show = true
                }
                else {
                    self.show = false
                }
            }
            
            checkAdminExists(postId: post.id, uid: Auth.auth().currentUser!.uid) { result in
                if (result == true) {
                    self.admin = true
                }
                else {
                    self.admin = false
                }
            }
        }
    }
    
    func checkAdminExists(postId: String, uid: String, completion: @escaping ((Bool) -> () )) {
        self.userCollection.document(postId).collection("admins").whereField("uid", isEqualTo: uid).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is already a user with this email")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
}


