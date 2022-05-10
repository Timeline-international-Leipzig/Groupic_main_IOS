//
//  FollowButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 17.03.22.
//

import SwiftUI
import Firebase

struct FollowButton: View {
    @ObservedObject var followService = FollowService()
    @EnvironmentObject var session: SessionStore
    
    var user: UserModel
    
    @Binding var followingCount: Int
    @Binding var followersCount: Int
    @Binding var followCheck: Bool
    
    init(user: UserModel, followCheck: Binding<Bool>, followingCount: Binding<Int>, followersCount: Binding<Int>) {
        self.user = user
        self._followCheck = followCheck
        self._followingCount = followingCount
        self._followersCount = followersCount
    }

    func follow() {
        if !self.followCheck {
            followService.follow(userId: user.uid, profileImageUrl: user.profileImageUrl, currentUserUid: Auth.auth().currentUser!.uid, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }) {
                (followersCount) in
                self.followersCount = followersCount
            }
            
            self.followCheck = true
        } else {
            followService.unfollow(userId: user.uid, followingCount: {
                (followingCount) in
                self.followingCount = followingCount
            }) {
                (followersCount) in
                self.followersCount = followersCount
            }
            
            self.followCheck = false
        }
    }
    
    func followState(userId: String) -> Bool {
        ProfileService.followingId(userId: userId).getDocument {
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
            Text((self.followState(userId: user.uid)) ? "Entfernen": "Hinzufügen")
                .background(Color.gray)
                .foregroundColor(.black)
        })
    }
}

