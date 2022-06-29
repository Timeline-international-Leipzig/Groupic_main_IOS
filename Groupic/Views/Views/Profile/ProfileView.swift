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
    
    @State var width = UIScreen.main.bounds.width - 90
    @State var x = UIScreen.main.bounds.width + 90
    
    var body: some View {
        ZStack {
            
            TabView(user: self.session.session, x: $x).zIndex(1)
            
            ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
                                
                SideMenue()
                    .shadow(color: Color.black.opacity(x != 0 ? 0.1 : 0), radius: 5, x: 5, y: 0)
                    .offset(x: x)
                    .background(Color.black.opacity(x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical).onTapGesture {
                        
                        withAnimation{
                            
                            x = width
                        }
                    })
            }.zIndex(1)
            
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
