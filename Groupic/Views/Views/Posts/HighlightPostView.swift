//
//  HighlightPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//

import SwiftUI
import Firebase

struct HighlightPostView: View {
    @StateObject var profileService = ProfileService()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.profileService.posts, id: \.dateN) {
                    (post) in
                
                    HighlightPostCardView(postModel: post)
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
