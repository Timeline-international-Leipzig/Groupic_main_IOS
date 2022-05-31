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
                
                ProfileHeader(user: self.session.session!)
                
                MidTabBarView().padding(.top, 40)
                
            }
            
        }
        .background(Color("mainColor"))
        .ignoresSafeArea()
        .coordinateSpace(name: "pullToRefresh")
    }
}
