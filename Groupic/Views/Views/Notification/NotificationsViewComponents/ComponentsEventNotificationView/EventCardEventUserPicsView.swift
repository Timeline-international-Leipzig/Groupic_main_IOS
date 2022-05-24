//
//  EventUserPicsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 02.05.22.
//

import SwiftUI
import Firebase

struct EventCardEventUserPicsView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @Binding var post: PostModel?
    
    var body: some View {
        HStack {
            ForEach(self.profileService.usersUid, id: \.uid) {
                (userUid) in
                
                ForEach(profileService.users, id: \.uid) {
                    (user) in
                
                    if user.uid == userUid.uid {
                        HorizontalPicView(userModel: user)
                    }
                }
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllEventUsers(postId: post!.postId)
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
        }
    }
}




