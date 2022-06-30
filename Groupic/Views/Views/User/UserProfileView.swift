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
            
            VStack {
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    ).colorInvert()
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
            }.zIndex(1)
            
            
            VStack {
                
                UserTabView(user: user!, next: $next)
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                
                ZStack {
                    
                    UserProfileHeader(user: user)
                }
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {}
                    
                    VStack {
                        
                        UserMidTabBarView(user: user!)
                    }
                    .offset(y: -10)
                }
                .coordinateSpace(name: "pullToRefresh")
            }
            
            
        }.background(Color("mainColor"))
            .ignoresSafeArea()
    }
}


