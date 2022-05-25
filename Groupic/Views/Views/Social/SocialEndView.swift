//
//  SocialEndView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 26.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SocialEndView: View {
    @StateObject var profileService = ProfileService()
    
    @State var isLoading = false
    @State var followCheck = false
    
    @State private var value: String = ""
    @State var users: [UserModel] = []
    @State var currentUser: UserModel?
    
    @State var next = false
    
    var body: some View {
        ZStack {
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
            
            VStack {
                ZStack {
                    HStack(spacing: 15) {
                        Spacer()
                        
                        Text("Social")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(alignment: .center)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color("AccentColor"))
                    
                    HStack() {
                        Spacer()
                        
                        
                    }
                    .padding()
                }
                
                ScrollView {
                    VStack(alignment: .leading) {
                        SearchBar(value: $value)
                            .onChange(of: value, perform: {
                                new in
                                
                                searchUsers()
                            })
                    }
                    
                    ZStack {
                        VStack {
                            Text("Unsozial")
                        }
                        
                        SocialFriendsEventsView()
                        
                        VStack {
                            if !isLoading || self.value != "" {
                                ForEach(users, id: \.uid) {
                                    user in
                                    
                                    HStack {
                                        Button(action: {
                                            self.currentUser = user
                                            
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
                                                        .padding()
                                                }
                                                else {
                                                    WebImage(url: URL(string: user.profileImageUrl))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 60, height: 60, alignment: .center)
                                                        .clipShape(Circle())
                                                        .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                                                        .background(Color.white)
                                                        .padding()
                                                }
                                                
                                                Text(user.userName)
                                                    .font(.subheadline)
                                                    .bold()
                                                
                                                Spacer()
                                                
                                                /*
                                                 if (user.uid == Auth.auth().currentUser!.uid) {
                                                 } else {
                                                 HStack {
                                                 FollowButton(user: user, followCheck: $profileService.followCheck, followingCount:    $profileService.following, followersCount: $profileService.follower)
                                                 .padding(.horizontal)
                                                 }
                                                 .onAppear {
                                                 self.profileService.followStateUser(userId: user.uid)
                                                 }
                                                 }
                                                 */
                                            }
                                            .padding()
                                        })
                                    }
                                    
                                    
                                    Divider().background(Color("AccentColor"))
                                }
                                
                                Spacer()
                                
                                NavigationLink(destination: UserProfileView(user: $currentUser, next: $next), isActive: self.$next, label: {
                                    EmptyView()
                                })
                            }
                        }
                        .background(Color.white)
                    }
                }
                .background(Color.white)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
        }
    }
    
    func searchUsers() {
        isLoading = true
        
        SearchService.searchUser(input: value) {
            (users) in
            
            self.isLoading = false
            self.users = users
        }
    }
}
