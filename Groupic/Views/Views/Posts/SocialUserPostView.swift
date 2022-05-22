//
//  SocialUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.04.22.
//

import SwiftUI

struct SocialUserPostView: View {
    @StateObject var profileService = ProfileService()
    @State var user: UserModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: -6) {
                ForEach(self.profileService.posts, id: \.dateN) {
                    (post) in
                    
                    ForEach(self.profileService.postsUid, id: \.postId) {
                        (posts) in
                        
                        if post.postId == posts.postId {
                            SocialPostCardView(postModel: post, user: user)
                            //PostCardView(postModel: post)
                            //PostCardBottomView(postModel: post)
                        }
                    }
                }
            }.padding(.top, 5)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadUserPosts(userId: user.uid)
            self.profileService.allPosts(userId: user.uid)
        }
 
    }
}

