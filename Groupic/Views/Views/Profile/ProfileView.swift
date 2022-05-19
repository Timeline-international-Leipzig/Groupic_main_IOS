//
//  ProfileView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 11/10/2021.
//

import SwiftUI
import Firebase

struct ProfileView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ZStack {
 
            TabView(user: self.session.session).zIndex(1)
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                            // do your stuff when pulled
                        }
                    
                    VStack {
                        ProfileHeader(user: self.session.session!)
                        
                        MidTabBarView()
                    }
                    //.offset(y: -10)
                }
                .background(Color("background"))
                .ignoresSafeArea()
                .coordinateSpace(name: "pullToRefresh")
            }
        }
    }
}
