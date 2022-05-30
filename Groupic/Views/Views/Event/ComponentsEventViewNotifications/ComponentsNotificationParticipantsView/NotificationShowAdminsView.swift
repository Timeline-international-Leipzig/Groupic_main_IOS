//
//  AddShow.swift
//  Groupic
//
//  Created by Anatolij Travkin on 22.05.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct NotificationShowAdminsView: View {
    @ObservedObject var followService = FollowService()
    
    var userCollection = Firestore.firestore().collection("events")
    
    @State var userSelected: UserModel?
    @State var next = false
    
    @State var user: UserModel
    @State var post: PostModel?
    
    @State var show = false
    @State var admin = false
    
    var body: some View {
        VStack {
            if user.uid == post!.ownerId || show == true {
                NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                Button(action: {
                    self.userSelected = user
                    
                    next.toggle()
                }, label: {
                    HStack {
                        if user.profileImageUrl == "" {
                            Image("profileImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                        }
                        
                        else {
                            WebImage(url: URL(string: user.profileImageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 60, height: 60, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                        }
                        
                        Text(user.userName)
                            .font(.subheadline)
                            .bold()
                        
                        Spacer()
                        
                        if (user.uid != post!.ownerId && admin == true) || (Auth.auth().currentUser!.uid == post!.ownerId && user.uid != post!.ownerId) {
                            Button(action: {
                                followService.deMakeAdminEvent(userId: user.uid, postId: post!.postId)
                            }, label: {
                                Text("Entfernen")
                                    .font(.subheadline)
                                    .bold()
                            })
                        }
                        else {}
                    }
                    .padding()
                })
            }
            else {}
        }
        .onAppear {
            checkAdminExists(postId: post!.postId, uid: user.uid) { result in
                if (result == true) {
                    self.show = true
                }
                else {
                    self.show = false
                }
            }
            
            checkAdminExists(postId: post!.postId, uid: Auth.auth().currentUser!.uid) { result in
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


