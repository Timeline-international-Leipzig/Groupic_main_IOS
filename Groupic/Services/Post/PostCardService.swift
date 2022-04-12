//
//  PostCardService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.01.22.
//

import Foundation
import Firebase
import SwiftUI

class PostCardService: ObservableObject {
    @Published var post: PostModel!
    @Published var isLiked = false
    
    func hasLikedPost() {
        isLiked = (post.likes["\(Auth.auth().currentUser!.uid)"] == true) ? true: false
    }
    
    func like() {
        post.likeCount += 1
        isLiked = true
        
        PostService.postUserId(userId: post.ownerId).collection("posts").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.allPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": true])
    }
    
    func unlike() {
        post.likeCount -= 1
        isLiked = false
        
        PostService.postUserId(userId: post.ownerId).collection("posts").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.allPosts.document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
        
        PostService.timelineUserId(userId: post.ownerId).collection("timeline").document(post.postId).updateData(["likeCount": post.likeCount, "\(Auth.auth().currentUser!.uid)": false])
    }
}
