//
//  EventUserPicsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 02.05.22.
//

import SwiftUI
import Firebase

struct EventUserPicsView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @Binding var post: PostModel
    @Binding var showparticipants: Bool
    
    var body: some View {
        Button(action: {
            self.showparticipants.toggle()
        }, label: {
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
            .frame(width: UIScreen.main.bounds.width)
            .navigationTitle("")
            .navigationBarHidden(true)
            .onAppear {
                self.profileService.loadAllEventUsers(postId: post.id)
                self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            }
            .background(Color.gray)
        })
    }
}

