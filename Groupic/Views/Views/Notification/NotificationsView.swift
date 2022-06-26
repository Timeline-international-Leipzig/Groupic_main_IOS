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
                                
                                Spacer()
                                
                                Text("Nachrichten")
                                    .font(.custom("Inter-Regular", size: 22))
                                    .foregroundColor(.white)
                                    .frame(alignment: .center)
                                
                                Spacer()
                                
                            }.padding(.top, 50)
                            
                            HStack {
                                Button(action: {
                                    self.back.toggle()
                                }, label: {
                                    Image(systemName: "chevron.left")
                                        .foregroundColor(.white)
                                })
                                
                                Spacer()
                            }
                            .padding(.top, 50)
                            .padding(.leading, 20)
                        }
                        
                        Spacer()
                    }.zIndex(3)
                    
                    VStack {
                        
                        HStack {
                            Rectangle().frame(width: getRectView().width, height: 100)
                        }
                        .background(Color(.black))
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                            ).colorInvert()
                        
                        Spacer()
                        
                        HStack {
                            Rectangle().frame(width: getRectView().width, height: 100)
                        }
                        .background(Color(.black))
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                            ).colorInvert()
                    }.zIndex(2)
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                Text("Keine neuen Nachrichten")
                                    .font(.custom("Inter-Regular", size: 18))
                                    .padding(.top, 150)
                                
                                Spacer()
                            }
                            
                            VStack {
                                ForEach(profileService.users, id: \.uid) {
                                    (user) in
                                    
                                    UserNotificationView(user: user)
                                }
                                
                                ForEach(profileService.users, id: \.uid) {
                                    (user) in
                                    
                                    EventNotificationView(user: user)
                                }
                                
                                Spacer()
                            }.padding(.top, 100)
                        }
                    }.zIndex(1)
                }
            }
            .background(Color("mainColor"))
            .ignoresSafeArea()
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
        }
    }
}

