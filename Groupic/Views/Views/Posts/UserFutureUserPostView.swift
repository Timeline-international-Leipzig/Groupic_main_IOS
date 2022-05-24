//
//  UserFutureUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 18.05.22.
//

import SwiftUI
import Firebase

struct UserFutureUserPostView: View {
    @StateObject var profileService = ProfileService()
    
    @State var user: UserModel
    
    @State var date = Date()
    
    var body: some View {
        ScrollView {
            VStack(spacing: -6) {
                ForEach(profileService.postsUid, id: \.postId) {
                    (postUid) in
                    
                    ForEach(self.profileService.posts, id: \.postId) {
                        (post) in
                        
                        if (postUid.postId == post.postId) && post.startDate > date {
                           PostCardView(postModel: post, userModel: user)
                        }
                    }
                }
            }.padding(.top, 5)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.allPosts(userId: user.uid)
            self.profileService.loadUserPosts(userId: user.uid)
        }
    }
}


