//
//  AddShow.swift
//  Groupic
//
//  Created by Anatolij Travkin on 22.05.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct EventContactsView: View {
    var userCollection = Firestore.firestore().collection("events")
    
    @State var userSelected: UserModel?
    @State var next = false
    
    @State var user: UserModel
    @State var post: PostModel
    
    @State var show = false
    
    var body: some View {
        VStack {
            NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            if show == false {
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
                                                      
                        Spacer()
                        
                        VStack {
                            EventInviteButton(user: user, post: post)
                        }
                    }
                    .padding()
                })
            }
            else {}
        }
        .onAppear {
            checkIfEmailOfAccountExists(postId: post.id, uid: user.uid) { result in
                if (result == true) {
                    self.show = true
                }
                else {
                    self.show = false
                }
            }
        }
    }
    
    func checkIfEmailOfAccountExists(postId: String, uid: String, completion: @escaping ((Bool) -> () )) {
        self.userCollection.document(postId).collection("participants").whereField("uid", isEqualTo: uid).getDocuments() {
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


