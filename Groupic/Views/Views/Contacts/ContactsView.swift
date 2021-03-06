//
//  ContactsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 25.03.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ContactsView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @State var userSelected: UserModel?
    @State var users: [UserModel] = []
    
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
                                self.userSelected = user
                                
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
                
                NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                    EmptyView()
                })
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadUser(userId: Auth.auth().currentUser!.uid)
        }
    }
}
