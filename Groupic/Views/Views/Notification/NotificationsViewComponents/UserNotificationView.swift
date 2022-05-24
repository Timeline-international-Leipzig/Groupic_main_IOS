//
//  EventNotificationView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 23.05.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct UserNotificationView: View {
    @StateObject var profileService = ProfileService()
    @ObservedObject var followService = FollowService()
    @State var user: UserModel
    
    @State var next = false
    @State var userSelected: UserModel?
    
    var body: some View {
        VStack {
            ForEach(profileService.requestsUser, id: \.uid) {
                (users) in
                
                if user.uid == users.uid {
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
                            
                            VStack {
                                Button(action: {
                                    followService.acceptFollow(userId: user.uid)
                                }, label: {
                                    Text("Annehmen")
                                })
                                
                                Button(action: {
                                    followService.declineFollow(userId: user.uid)
                                }, label: {
                                    Text("Ablehnen")
                                })
                            }
                        }
                        .padding()
                    })
                }
            }
        }
        .onAppear {
            self.profileService.loadRequestUser(userId: Auth.auth().currentUser!.uid)
        }
        
        NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
            EmptyView()
        })
    }
}


