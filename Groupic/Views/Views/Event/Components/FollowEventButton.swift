//
//  FollowEventButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.04.22.
//

import SwiftUI
import Firebase

struct FollowEventButton: View {
    @ObservedObject var followService = FollowService()
    @EnvironmentObject var session: SessionStore
    
    var post: PostModel

    @Binding var followCheck: Bool
    
    init(post: PostModel, followCheck: Binding<Bool>) {
        self.post = post
        self._followCheck = followCheck
    }

    func follow() {
        if !self.followCheck {
            followService.followEvent(postId: post.postId, currentUserUid: Auth.auth().currentUser!.uid)
            
            self.followCheck = true
        } else {
            followService.unfollowEvent(postId: post.postId)
            
            self.followCheck = false
        }
    }
    
    func followEventState(postId: String) -> Bool {
        ProfileService.followingEventId(postId: postId).getDocument {
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
            Text((self.followEventState(postId: post.postId)) ? "Verlassen": "Beitreten")
                .background(Color.gray)
                .foregroundColor(.black)
        })
    }
}


