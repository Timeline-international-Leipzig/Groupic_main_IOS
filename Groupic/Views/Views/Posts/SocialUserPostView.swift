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
            VStack {
                ForEach(self.profileService.posts, id: \.dateN) {
                    (post) in
                
                    SocialPostCardView(postModel: post, user: user)
                    //PostCardView(postModel: post)
                    //PostCardBottomView(postModel: post)
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadUserPosts(userId: user.uid)
        }
 
    }
}

