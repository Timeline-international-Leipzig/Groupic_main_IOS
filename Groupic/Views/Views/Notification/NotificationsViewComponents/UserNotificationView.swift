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
                            if user.profileImageId == "" {
                                Image("profileImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(Circle())
                            }
                            else {
                                WebImage(url: URL(string: user.profileImageId))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50, alignment: .center)
                                    .clipShape(Circle())
                            }
                            
                            Text(user.username)
                                .font(.custom("Inter-ExtraBold", size: 18))
                                .foregroundColor(.white)
                                .padding(.horizontal)
                            
                            Spacer()
                            
                            HStack {
                                Button(action: {
                                    followService.acceptFollow(userId: user.uid)
                                }, label: {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                }).padding(.horizontal)
                                
                                Button(action: {
                                    followService.declineFollow(userId: user.uid)
                                }, label: {
                                    Image(systemName: "multiply")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                }).padding(.horizontal)
                            }
                        }
                        .padding()
                        .background(Color("buttonColor"))
                    }).padding(3)
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


