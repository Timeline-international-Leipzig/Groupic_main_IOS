//
//  EventNotificationView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 23.05.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct EventNotificationView: View {
    @StateObject var profileService = ProfileService()
    @ObservedObject var followService = FollowService()
    @State var user: UserModel
    
    @State var next = false
    @State var userSelected: UserModel?
    
    var body: some View {
        VStack {
            ForEach(profileService.requestsEventUser, id: \.userId) {
                (users) in
                
                if user.uid == users.userId {
                    
                    Button(action: {
                        self.userSelected = user
                        
                        self.next.toggle()
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
                            
                            EventCard(user: user, event: users)
                            
                            Spacer()
                            
                            VStack {
                                Button(action: {
                                    followService.acceptInvite(userId: Auth.auth().currentUser!.uid, postId: users.postId)
                                }, label: {
                                    Text("Annehmen")
                                })
                                
                                Button(action: {
                                    followService.delInviteIntoEvent(userId: Auth.auth().currentUser!.uid, postId: users.postId)
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
            self.profileService.loadRequestEvent(userId: Auth.auth().currentUser!.uid)
        }
        
        NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
            EmptyView()
        })
    }
}


