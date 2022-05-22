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
    @ObservedObject var followService = FollowService()
    @EnvironmentObject var session: SessionStore
    
    @State var userSelected: UserModel?
    @State var users: [UserModel] = []
    
    @State var next = false
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Noch keine Kontakte")
                }
            
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
                                    if user.profileImageUrl == "" {
                                        Image("profileImage")
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                                    }
                                    else {
                                        WebImage(url: URL(string: user.profileImageUrl))
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 50, height: 50, alignment: .center)
                                            .clipShape(Circle())
                                            .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                                    }
              
                                    Text(user.userName)
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .bold))
                                        .padding(.horizontal)
              
                                    Spacer()
                                    
                                    VStack {
                                    Button(action: {
                                        followService.deleteContact(userId: user.uid)
                                    }, label: {
                                        Text("Entfernen")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .bold))
                                            .padding(5)
                                            .background(
                                                Color("lightBlue")
                                                    .cornerRadius(5)
                                            )
                                    })
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
                .background(Color(.systemGray6))
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
