//
//  UserProfileView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 18.03.22.
//

import SwiftUI

struct UserProfileView: View {
    
    @Binding var user: UserModel?

    @StateObject var profileService = ProfileService()
    
    @Binding var next: Bool
    
    var body: some View {
        ZStack {
            
            UserTabView(user: user!, next: $next).zIndex(1)
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {}
                    
                    VStack {
                        UserProfileHeader(user: user)
                        
                        UserMidTabBarView(user: user!)
                    }
                }
                .background(Color("background"))
                .ignoresSafeArea()
                .coordinateSpace(name: "pullToRefresh")
        }
    }
}


