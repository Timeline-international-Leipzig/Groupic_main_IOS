//
//  HomeView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27/09/2021.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        NavigationView {
            Group {
                if (session.session != nil && Auth.auth().currentUser?.isEmailVerified == true) {
                    CustomTabView()
                }
                else {
                    LoginView()
                }
            }
            .onAppear(perform: listen)
        }
        .accentColor(
            Color("AccentColor")
        )
    }
    
    func listen() {
        session.listen()
    }
}
