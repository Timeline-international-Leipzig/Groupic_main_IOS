//
//  ProfileSettingsViewProfileHeader.swift
//  Groupic
//
//  Created by Anatolij Travkin on 05.04.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileSettingsViewProfileHeader: View {
    @Binding var profileImage: Image?
    @Binding var backProfileImage: Image?
    
    var user: UserModel?
    
    var body: some View {
        ZStack {
            if backProfileImage != nil {
                backProfileImage!
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectView().width, height: 180, alignment: .center)
                    .cornerRadius(0)
            }
            else {
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
            }
            
            VStack {
                if profileImage != nil {
                    profileImage!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125, alignment: .center)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                }
                else {
                    if user!.profileImageId == "" {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                    }
                    else {
                        WebImage(url: URL(string: user!.profileImageId))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                    }
                }
            }
            .padding(.bottom, -160)
        }
    }
}

