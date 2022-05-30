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
        VStack {
            ForEach(self.profileService.posts, id: \.postId) {
                (post) in
                
                ForEach(profileService.users, id: \.uid) {
                    (user) in
                    
                    if post.ownerId == user.uid {
                        SocialUserPostView(user: user, posts: post)
                    }
                }
            }
        }
        .background(Color.white)
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.allPosts(userId: Auth.auth().currentUser!.uid)
        }
    }
}