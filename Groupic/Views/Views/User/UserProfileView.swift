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
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
            
            VStack {
                UserTabView(user: user!, next: $next)
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {}
                    
                    VStack {
                        UserProfileHeader(user: user)
                        
                        UserMidTabBarView(user: user!)
                    }
                    .offset(y: -10)
                }
                .background(Color.white)
                .coordinateSpace(name: "pullToRefresh")
            }
        }
    }
}


