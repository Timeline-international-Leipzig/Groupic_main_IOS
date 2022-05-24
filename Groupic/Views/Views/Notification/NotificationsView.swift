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
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
            
            VStack(alignment: .center, spacing: 0) {
                ZStack {
                    HStack(spacing: 15) {
                        Spacer()
                        
                        Text("Nachrichten")
                            .font(.title3)
                            .foregroundColor(.white)
                            .frame(alignment: .center)
                        
                        Spacer()
                    }
                    .padding()
                    .background(Color("AccentColor"))
                    
                    HStack() {
                        Button(action: {
                            self.back.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                    }
                    .padding()
                }
                
                ScrollView {
                    ZStack {
                        VStack {
                            Text("Keine neuen Nachrichten")
                                .padding(.top)
                            
                            Spacer()
                        }
                        
                        VStack {
                            ForEach(profileService.users, id: \.uid) {
                                (user) in
                                
                                UserNotificationView(user: user)
                                
                                EventNotificationView(user: user)
                            }
                            
                            Spacer()
                        }
                        .background(Color(.systemGray6))
                    }
                }
            }
            .background(Color(.systemGray6))
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
        }
    }
}

