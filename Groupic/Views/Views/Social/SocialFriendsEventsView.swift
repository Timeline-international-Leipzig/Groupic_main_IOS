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
            
            ForEach(profileService.users, id: \.uid) {
                (user) in
                
                ForEach(profileService.followUsers, id: \.uid) {
                    (users) in
                    
                    if user.uid == users.uid {
                        SocialUserPostView(user: user)
                    }
                }
            }
        }
        .onAppear {
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadUser(userId: Auth.auth().currentUser!.uid)
        }
    }
}
