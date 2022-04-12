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
            
            ScrollView(.vertical, showsIndicators: false) {
                PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                    
                    }
                
                VStack {
                    UserProfileHeader(user: user!)

                    
                    UserMidTabBarView(user: user!)
                }
            }
            .padding(.top, 47.5)
            .background(Color.white)
            .coordinateSpace(name: "pullToRefresh")
            
            VStack {
                UserTabView(user: user!, next: $next)
                
                Spacer()
            }
        }
    }

}


