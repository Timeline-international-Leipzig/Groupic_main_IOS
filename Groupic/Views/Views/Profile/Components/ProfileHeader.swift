//
//  ProfileHeader.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.01.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileHeader: View {
    @EnvironmentObject var session: SessionStore
    
    var user: UserModel?
    
    @State var nextProfile = false
    
    var body: some View {
        NavigationLink(destination: ProfileSettingsView(session: user!, back: $nextProfile), isActive: self.$nextProfile, label: {
            EmptyView()
        })
        
            ZStack {
                VStack {
                    if user!.backgroundImageUrl == "" {
                        Image("grey")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRectView().width, height: 180, alignment: .center)
                            .cornerRadius(0)
                    }
                    else {
                        WebImage(url: URL(string: user!.backgroundImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRectView().width, height: 180, alignment: .center)
                            .cornerRadius(0)
                    }
                    
                    
                    HStack {
                        Text(user!.userName)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        Button(action: {
                            self.nextProfile.toggle()
                        }, label: {
                            Text("Profil bearbeiten")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(.white))
                                .font(.headline)
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        })
                    }.padding(.horizontal, 8)
                        .padding(.vertical, 20)
                }
                
                ZStack {
                    VStack {
                        if user!.profileImageUrl == "" {
                            Image("profileImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                        }
                        else {
                            WebImage(url: URL(string: user!.profileImageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                        }
                    }
                }
                .offset(y: 50)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

