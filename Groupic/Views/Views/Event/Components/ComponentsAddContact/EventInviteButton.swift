//
//  FollowButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 17.03.22.
//

import SwiftUI
import Firebase

struct EventInviteButton: View {
    @ObservedObject var followService = FollowService()
    @EnvironmentObject var session: SessionStore
    
    var user: UserModel
    var post: PostModel
    
    @State var followCheck = false
    
    init(user: UserModel, post: PostModel) {
        self.user = user
        self.post = post
    }
    
    func follow() {
        if !self.followCheck {
            followService.inviteIntoEvent(userId: user.uid, postId: post.id)
            
            self.followCheck = true
        } else {
            followService.unfollow(userId: user.uid, followingCount: {
                (followingCount) in
            }) {
                (followersCount) in
                
            }
            
            self.followCheck = false
        }
    }
    
    func followState(userId: String, postId: String) -> Bool {
        ProfileService.followersInviteEventId(postId: postId, userId: userId).getDocument {
            (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = true
            }
            else {
                self.followCheck = false
            }
        }
        
        return self.followCheck
    }
    
    var body: some View {
        Button(action: {
            self.follow()
        }, label: {
            Text((self.followState(userId: user.uid, postId: post.id)) ? "Eingeladen": "Einladen")
                .foregroundColor(Color("buttonText"))
                .font(.system(size: 14, weight: .bold))
            //.font(.headline)
                .padding(5)
                .background(
                    Color("buttonColor")
                        .cornerRadius(5)
                )
        })
    }
}


