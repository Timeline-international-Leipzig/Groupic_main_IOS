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
                        VStack(alignment: .leading) {
                            
                            EventCard(user: user, event: users)
                            
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
                                    .foregroundColor(.white)
                                    .font(.subheadline)
                                    .bold()
                                    .padding(.horizontal)
                                
                                Spacer()
                                
                                HStack {
                                    Button(action: {
                                        followService.acceptInvite(userId: Auth.auth().currentUser!.uid, postId: users.postId)
                                    }, label: {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                    }).padding(.horizontal)
                                    
                                    Button(action: {
                                        followService.delInviteIntoEvent(userId: Auth.auth().currentUser!.uid, postId: users.postId)
                                    }, label: {
                                        Image(systemName: "multiply")
                                            .foregroundColor(.white)
                                            .font(.system(size: 20))
                                    }).padding(.horizontal)
                                }
                            }
                        }
                        .padding()
                        .background(Color("mainColor"))
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


