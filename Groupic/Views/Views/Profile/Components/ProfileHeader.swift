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
                        Text(user!.userName).bold()
                        
                        Spacer()
                        
                        Button(action: {
                            self.nextProfile.toggle()
                        }, label: {
                            Text("Bearbeiten")
                                .background(Color.gray)
                                .foregroundColor(.black)
                        })
                        .padding()
                    }
                    .padding()
                }
                
                ZStack {
                    VStack {
                        if user!.profileImageUrl == "" {
                            Image("profileImage")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                        }
                        else {
                            WebImage(url: URL(string: user!.profileImageUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 125, height: 125, alignment: .center)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                        }
                    }
                }
                .offset(y: 60)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

