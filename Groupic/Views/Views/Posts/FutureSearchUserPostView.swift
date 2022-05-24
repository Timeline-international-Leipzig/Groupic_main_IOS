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
    
    @State var date = Date()
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Es gibt aktuell noch keine zukünftigen Ereignisse")
                }
            
                VStack {
                    ForEach(self.profileService.posts, id: \.dateN) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if (postUid.postId == post.postId) && post.startDate > date {
                                PostCardView(postModel: post, userModel: user)
                            }
                        }
                    }
                }
                .background(Color(.white))
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.allPosts(userId: user.uid)
            self.profileService.loadUserPosts(userId: user.uid)
        }
    }
}
