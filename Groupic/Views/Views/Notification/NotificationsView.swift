//
//  NotificationsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 08.12.21.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct NotificationsView: View {
    @ObservedObject var followService = FollowService()
    @StateObject var profileService = ProfileService()
    @Binding var back: Bool
    
    @State var next = false
    
    @State var userSelected: UserModel?
    @State var users: [UserModel] = []
    
    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    
                    VStack {
                        
                        ZStack {
                            
                            HStack {
                                
                                Button(action: {
                                    self.back.toggle()
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                })
                                .padding(.leading)
                                .padding(.top, 50)
                                
                                Spacer()
                                
                            }.zIndex(1)
                            
                            Text("Nachrichten")
                                .padding(.top, 50)
                                .font(.system(size: 26, weight: .bold))
                                .foregroundColor(.white)
                                .hCenter()
                                .zIndex(1)
                            
                            HStack {
                                Rectangle().frame(width: getRectView().width, height: 100)
                            }.background(Color(.black))
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                                ).colorInvert()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Rectangle().frame(width: getRectView().width, height: 100)
                        }.background(Color(.black))
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                            ).colorInvert()
                    }.zIndex(1)
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                                                
                                Text("Keine neuen Nachrichten")
                                
                            }.padding(.top, 300)
                            
                            VStack {
                                ForEach(profileService.users, id: \.uid) {
                                    (user) in
                                    
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
                                                        .font(.system(size: 15, weight: .bold))
                                                        .padding(.leading)
                                                    
                                                    Spacer()
                                                    
                                                    HStack {
                                                        Button(action: {
                                                            followService.acceptFollow(userId: user.uid)
                                                        }, label: {
                                                            Image(systemName: "checkmark")
                                                                .foregroundColor(.white)
                                                                .font(.system(size: 20, weight: .bold))                                                        }).padding(.horizontal)
                                                        
                                                        Button(action: {
                                                            followService.declineFollow(userId: user.uid)
                                                        }, label: {
                                                            Image(systemName: "multiply")
                                                                .foregroundColor(.white)
                                                            .font(.system(size: 20, weight: .bold))                                                        }).padding(.horizontal)
                                                    }
                                                }
                                                .padding()
                                            })
                                        }
                                    }
                                }
                                
                                //Spacer()
                                
                                NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                                    EmptyView()
                                })
                            }
                            .background(Color("lightDark"))
                            .padding(.top, 100)
                        }
                    }
                }
                .background(Color("background"))
                .ignoresSafeArea()
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            .onAppear {
                self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
                self.profileService.loadRequestUser(userId: Auth.auth().currentUser!.uid)
            }
        }
    }
}

