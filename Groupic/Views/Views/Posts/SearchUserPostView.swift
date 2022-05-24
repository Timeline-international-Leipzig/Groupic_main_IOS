//
//  ProfileUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.03.22.
//
import SwiftUI
import Firebase

struct SearchUserPostView: View {
    @StateObject var profileService = ProfileService()
    
    @State var user: UserModel
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Es gibt aktuell noch keine Ereignisse")
                }
                
                VStack {
                    ForEach(self.profileService.posts, id: \.postId) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if postUid.postId == post.postId {
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
