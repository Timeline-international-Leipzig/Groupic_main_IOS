//
//  UserContactsView.swift
//  Groupic
//
//
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct UserContactsView: View {
    @StateObject var profileService = ProfileService()
    
    @State var users: [UserModel] = []
    @State var currentUser: UserModel?
    @State var user: UserModel
    
    @State var next = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(profileService.users, id: \.uid) {
                    (user) in
                    
                    ForEach(profileService.followUsers, id: \.uid) {
                        (users) in
                        
                        if user.uid == users.uid {
                            Button(action: {
                                self.currentUser = user
                                
                                next.toggle()
                            }, label: {
                                HStack {
                                    WebImage(url: URL(string: user.profileImageUrl))
                                        .resizable()
                                        .scaledToFit()
                                        .clipShape(Circle())
                                        .frame(width: 60, height: 60, alignment: .trailing)
                                        .padding()
                     
                                    Text(user.userName)
                                        .font(.subheadline)
                                        .bold()
                                    
                                    Spacer()
                                    
                                    if (user.uid == Auth.auth().currentUser!.uid) {
                                    } else {
                                        FollowButton(user: user, followCheck: $profileService.followCheck, followingCount: $profileService.following, followersCount: $profileService.follower)
                                        .padding(.horizontal)
                                    }
                                }
                                .padding()
                            })
                        }
                }
                }
                
                NavigationLink(destination: UserProfileView(user: $currentUser, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllUser(userId: user.uid)
            self.profileService.loadUser(userId: user.uid)
        }
    }
}
