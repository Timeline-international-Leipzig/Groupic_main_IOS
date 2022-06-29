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
    @Binding var profileImageUI: UIImage?
    @Binding var backProfileImage: Image?
    @Binding var backProfileImageUI: UIImage?
    
    var user: UserModel?
    
    var body: some View {
        ZStack {
            if backProfileImageUI != nil || backProfileImage != nil {
                Image(uiImage: backProfileImageUI!)
                    .resizable()
                    .frame(width: getRectView().width, height: 180, alignment: .center)
            }
            else {
                if user!.titleImageId == "" {
                    Image("grey")
                        .resizable()
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                }
                else {
                    WebImage(url: URL(string: user!.titleImageId))
                        .resizable()
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                }
            }
            
            VStack {
                if profileImage != nil || profileImageUI != nil {
                    Image(uiImage: profileImageUI!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 125, height: 125, alignment: .center)
                        .clipShape(Circle())
                }
                else {
                    if user!.profileImageId == "" {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                    }
                    else {
                        WebImage(url: URL(string: user!.profileImageId))
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

