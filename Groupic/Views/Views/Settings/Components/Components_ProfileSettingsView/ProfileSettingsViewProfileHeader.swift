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
                    .frame(width: getRectView().width, height: 180, alignment: .center)
            }
            else {
                if user!.backgroundImageUrl == "" {
                    Image("grey")
                        .resizable()
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                }
                else {
                    WebImage(url: URL(string: user!.backgroundImageUrl))
                        .resizable()
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                }
            }
            
            VStack {
                if profileImage != nil {
                    profileImage!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125, alignment: .center)
                        .clipShape(Circle())
                }
                else {
                    if user!.profileImageUrl == "" {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                    }
                    else {
                        WebImage(url: URL(string: user!.profileImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                    }
                }
            }
            .padding(.top, 150)
        }
    }
}

