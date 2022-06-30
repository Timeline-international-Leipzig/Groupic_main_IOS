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
                    Text("Noch keine anstehenden Ereignisse")
                        .font(.custom("Inter-Regular", size: 16))
                }.padding(.top, 30)
                
                VStack(spacing: 1) {
                    ForEach(self.profileService.posts, id: \.id) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if (postUid.postId == post.id) && post.startDate > date {
                                PostCardView(postModel: post, userModel: self.session.session!)
                            }
                        }
                    }
                }.padding(.bottom, 100)
            }
        }
        .onAppear {
            self.profileService.allPosts(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadUserPosts(userId: Auth.auth().currentUser!.uid)
        }
    }
}

