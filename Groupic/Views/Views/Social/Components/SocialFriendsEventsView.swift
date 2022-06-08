//
//  SearchView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 13.12.21.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SocialFriendsEventsView: View {
    @StateObject var profileService = ProfileService()
    @State var next = false
    
    var body: some View {
        VStack(spacing: 1) {
            ForEach(self.profileService.posts, id: \.id) {
                (post) in
                
                ForEach(profileService.users, id: \.uid) {
                    (user) in
                    
                    if post.creatorId == user.uid {
                        SocialUserPostView(user: user, posts: post)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.allPosts(userId: Auth.auth().currentUser!.uid)
        }
    }
}
