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
    
    func searchUsers() {
        isLoading = true
        
        SearchService.searchUser(input: value) {
            (users) in
            
            self.isLoading = false
            self.users = users
        }
    }
    
    func followState(userId: String) {
        ProfileService.followingId(userId: userId).getDocument {
            (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = true
                }
            else {
                self.followCheck = false
            }
        }
    }
    
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
                }.zIndex(1)
                    
                VStack {
                    HStack(spacing: 15) {
                        Spacer()
                        
                        Button(action: {},
                               label: {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            
                        }).padding(.horizontal, 20)
                        
                        Text("username")
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
                    .padding(.bottom, 10)
                 
                    Spacer()
                }.zIndex(1)
            
            VStack {
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        SearchBar(value: $value)
                        .onChange(of: value, perform: {
                            new in
                            
                            searchUsers()
                        })
                    }.padding(.top, 80)
                    
                    ZStack {
                        SocialFriendsEventsView()
                        
                        VStack {
                       if !isLoading {
                           ForEach(users, id: \.uid) {
                    
                               user in
                               
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
                                       
                                       if (user.uid == Auth.auth().currentUser!.uid) {
                                       } else {
                                           FollowButton(user: user, followCheck: $profileService.followCheck, followingCount: $profileService.following, followersCount: $profileService.follower)
                                           .padding(.horizontal)
                                       }
                                   }
                                   .padding()
                               })
                               
                               Divider().background(Color("AccentColor"))
                           }
                           
                           NavigationLink(destination: UserProfileView(user: $currentUser, next: $next), isActive: self.$next, label: {
                               EmptyView()
                           })
                       }
                        }
                        .background(Color.white)
                        
                    }
                }
                .background(Color("background"))
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
        }.ignoresSafeArea()
    }
}
