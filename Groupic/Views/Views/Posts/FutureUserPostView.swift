//
//  FutureUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 28.03.22.
//

import SwiftUI
import Firebase

struct FutureUserPostView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @State var date = Date()
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Es gibt aktuell noch keine zukünftigen Ereignisse")
                }
                
                VStack {
                    ForEach(self.profileService.posts, id: \.id) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if (postUid.postId == post.id) && post.startDate > date {
                                PostCardView(postModel: post, userModel: self.session.session!)
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
            self.profileService.allPosts(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)
        }
    }
}

