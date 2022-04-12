//
//  HorizontalView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.01.22.
//
/*
import SwiftUI

struct HorizontalList: View {
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        HStack {
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
        }
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadUser(userId: Auth.auth().currentUser!.uid)
        }
    }
}

*/
