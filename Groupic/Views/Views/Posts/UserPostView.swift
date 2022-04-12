//
//  UserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 12.01.22.
//

import SwiftUI
import Firebase

struct UserPostView: View {
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.profileService.posts, id: \.dateN) {
                    (post) in
                
                    PostCardView(postModel: post)
                    //PostCardView(postModel: post)
                    //PostCardBottomView(postModel: post)
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)
        }
    }
}
