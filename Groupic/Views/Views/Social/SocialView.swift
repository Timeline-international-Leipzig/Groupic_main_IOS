//
//  SocialEndView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 26.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SocialView: View {
    @StateObject var profileService = ProfileService()
    
    @State var isLoading = false
    @State var followCheck = false
    
    @State private var value: String = ""
    @State var users: [UserModel] = []
    @State var currentUser: UserModel?
    
    @State var next = false
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    ).colorInvert()
                
                Spacer()
            }
            
            VStack {
                HStack(spacing: 15) {
                    Spacer()
                    
                    Button(action: {},
                           label: {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        
                    }).padding(.horizontal, 20)
                    
                    Text("Community")
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                    
                    Button(action: {},
                           label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        
                    }).padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.top, 50)
                
                Spacer()
            }.zIndex(1)
            
            
            VStack {
                
                VStack(alignment: .leading) {
                    SearchBar(value: $value)
                        .onChange(of: value, perform: {
                            new in
                            
                            searchUsers()
                        })
                }
                
                ScrollView {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                        // do your stuff when pulled
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
                                                if user.profileImageId == "" {
                                                    Image("profileImage")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 50, height: 50, alignment: .center)
                                                        .clipShape(Circle())
                                                        .padding()
                                                }
                                                else {
                                                    WebImage(url: URL(string: user.profileImageId))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 50, height: 50, alignment: .center)
                                                        .clipShape(Circle())
                                                        .padding()
                                                }
                                                
                                                Text(user.username)
                                                    .foregroundColor(.white)
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
                                    }.background(Color("mainColor"))
                                    
                                }
                                
                                Spacer()
                                
                                NavigationLink(destination: UserProfileView(user: $currentUser, next: $next), isActive: self.$next, label: {
                                    EmptyView()
                                })
                            }
                        }
                    }
                }
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            .padding(.top, 80)
        }.background(Color("mainColor"))
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
