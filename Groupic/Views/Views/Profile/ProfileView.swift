//
//  ProfileView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 11/10/2021.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
        
            VStack {
                TabView(user: self.session.session)
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                            // do your stuff when pulled
                        }
                    
                    VStack {
                        ProfileHeader(user: self.session.session!)
                        
                        MidTabBarView()
                    }
                    .offset(y: -10)
                }
                .background(Color.white)
                .coordinateSpace(name: "pullToRefresh")
            }
        }
    }
}
