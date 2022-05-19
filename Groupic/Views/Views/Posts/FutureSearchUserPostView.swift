//
//  FutureSearchUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 08.04.22.
//

import SwiftUI
import Firebase

struct FutureSearchUserPostView: View {
    @StateObject var profileService = ProfileService()
    @State var user: UserModel
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Es gibt aktuell noch keine zukünftigen Ereignisse")
                }
            
                VStack {
                    ForEach(self.profileService.posts, id: \.dateN) {
                        (post) in
                        
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadUserPosts(userId: user.uid)
        }
    }
}
