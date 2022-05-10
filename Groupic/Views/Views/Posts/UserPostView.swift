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
    @EnvironmentObject var session: SessionStore
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(profileService.postsUid, id: \.postId) {
                    (postUid) in
                    
                    ForEach(self.profileService.posts, id: \.postId) {
                        (post) in
                        
                        if postUid.postId == post.postId {
                            PostCardView(postModel: post, userModel: self.session.session!)
                        }
                    }
                }
            }
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear {
                self.profileService.allPosts(userId: Auth.auth().currentUser!.uid)
                self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)
            }
        }
    }
}
