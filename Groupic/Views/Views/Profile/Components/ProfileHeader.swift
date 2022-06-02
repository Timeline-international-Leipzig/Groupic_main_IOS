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
            
            VStack(spacing: 0) {
                if user!.titleImageId == "" {
                    Image("grey")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
                else {
                    WebImage(url: URL(string: user!.titleImageId))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
            }.ignoresSafeArea()
            
            VStack {
                if user!.profileImageId == "" {
                    Image("profileImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                }
                else {
                    WebImage(url: URL(string: user!.profileImageId))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                }
            }.padding(.top, 125)
            
            HStack {
                
                Text(user!.username)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                
                Spacer()
                
                Button(action: {
                    self.nextProfile.toggle()
                }, label: {
                    Text("Bearbeiten")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(Color(.white))
                        .font(.headline)
                        .padding(5)
                        .background(
                            Color("buttonColor")
                                .cornerRadius(5)
                        )
                })
            }
            .padding(.horizontal)
            .padding(.top, 200)
        }
        .background(Color("mainColor"))
        .ignoresSafeArea()
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

