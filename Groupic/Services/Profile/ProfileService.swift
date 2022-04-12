//
//  ProfileService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 12.01.22.
//

import Foundation
import Firebase

class ProfileService: ObservableObject {
    @Published var posts: [PostModel] = []
    @Published var users: [UserModel] = []
    @Published var followUsers: [UidUserModel] = []
    @Published var following = 0
    @Published var follower = 0
    
    @Published var followCheck = false
    
    static var follow = AuthService.storeRoot.collection("users")
    
    static var followEvent = AuthService.storeRoot.collection("allPosts")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return follow.document(userId).collection("following")
    }
    
    static func followersCollection(userId: String) -> CollectionReference {
        return follow.document(userId).collection("followers")
    }
    
    static func followingId(userId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("following").document(userId)
    }
    
    static func followingEventId(postId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("followingEvents").document(postId)
    }
    
    static func followersEventId(postId: String) -> DocumentReference {
        return followEvent.document(postId).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    static func followersId(userId: String) -> DocumentReference {
        return follow.document(userId).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    func loadUserPosts(userId: String) {
        PostService.loadUserPosts(userId: userId) {
            (posts) in
            
            self.posts = posts
        }
        
        follows(userId: userId)
        followsm(userId: userId)
    }
    
    func loadUser(userId: String) {
        PostService.loadUser(userId: userId) {
            (users) in
            
            self.followUsers = users
        }
    }
    
    func loadAllUser(userId: String) {
        PostService.loadAllUser(userId: userId) {
            (users) in
            
            self.users = users
        }
    }
    
    func loadAllPost(userId: String) {
        PostService.loadAllUser(userId: userId) {
            (users) in
            
            self.users = users
        }
    }
    
    func follows(userId: String) {
        ProfileService.followingCollection(userId: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.following = doc.count
            }
        }
    }
    
    func followsm(userId: String) {
        ProfileService.followersCollection(userId: userId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.follower = doc.count
            }
        }
    }
}
