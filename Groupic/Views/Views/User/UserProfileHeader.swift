//
//  UserProfileHeader.swift
//  Groupic
//
//  Created by Anatolij Travkin on 18.03.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct UserProfileHeader: View {
    var user: UserModel?
    
    @StateObject var profileService = ProfileService()
    
    @State var offset: CGFloat = 0
    
    
    var body: some View {
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


