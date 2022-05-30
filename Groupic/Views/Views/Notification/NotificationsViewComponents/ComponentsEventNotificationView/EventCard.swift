//
//  EventCard.swift
//  Groupic
//
//  Created by Anatolij Travkin on 23.05.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct EventCard: View {
    @StateObject var profileService = ProfileService()
    @ObservedObject var followService = FollowService()
    
    @State var next = false
    
    @State var user: UserModel
    @State var post: PostModel?
    @State var event: InviteUidModel
    
    var body: some View {
        VStack {
            ForEach(profileService.posts, id: \.postId) {
                (post) in
                
                if post.postId == event.postId {
                    Button(action: {
                        self.post = post
                        self.next.toggle()
                    }, label: {
                        HStack {
                            VStack {
                                Text("Zum Event:")
                                    .font(.subheadline)
                                    .bold()
                                
                                Text(post.caption)
                                    .font(.subheadline)
                                    .bold()
                            }
                        }
                        .padding()
                    })
                }
            }
        }
        .onAppear {
            self.profileService.allPosts(userId: Auth.auth().currentUser!.uid)
        }
        
        NavigationLink(destination: EventViewNotifications(postModel: post, userModel: $user, next: $next), isActive: self.$next, label: {
            EmptyView()
        })
    }
}

