//
//  FollowService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 17.03.22.
//

import SwiftUI
import Firebase

class FollowService: ObservableObject {
    func updateFollowCount(userId: String, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        ProfileService.followingCollection(userId: userId).getDocuments {
            (snap, error) in
            
            if let doc = snap?.documents {
                followingCount(doc.count)
            }
        }
        
        ProfileService.followersCollection(userId: userId).getDocuments {
            (snap, error) in
            
            if let doc = snap?.documents {
                followersCount(doc.count)
            }
        }
    }
        
    func manageFollow(userId: String, profileImageUrl: String, currentUserUid: String, followCheck: Bool, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        if !followCheck {
            follow(userId: userId, profileImageUrl: profileImageUrl, currentUserUid: currentUserUid, followingCount: followingCount, followersCount: followersCount)
        } else {
            unfollow(userId: userId, followingCount: followingCount, followersCount: followersCount)
        }
    }
        
    func follow(userId: String, profileImageUrl: String, currentUserUid: String, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        let user = UidUserModel.init(uid: userId)
        let AuthUser = UidCheckUserModel.init(uid: Auth.auth().currentUser!.uid, globalCheck: false, localCheck: false)
     
        guard let dict = try? user.asDictionary() else {
            return
        }
        
        guard let authDict = try? AuthUser.asDictionary() else {
            return
        }
        
        ProfileService.followingId(userId: userId).setData(dict) {
            (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
            
        ProfileService.followersId(userId: userId).setData(authDict) {
            (err) in
            
            if err == nil {
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
        
    func unfollow(userId: String, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        ProfileService.followingId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
            
        ProfileService.followersId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(userId: userId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
    
    func acceptFollow(userId: String) {
        
        let user = UidUserModel.init(uid: userId)
        let AuthUser = UidUserModel.init(uid: Auth.auth().currentUser!.uid)
     
        guard let dict = try? user.asDictionary() else {
            return
        }
        
        guard let authDict = try? AuthUser.asDictionary() else {
            return
        }
        
        ProfileService.acceptFollowingId(userId: userId).setData(dict) {_ in }
            
        ProfileService.acceptFollowersId(userId: userId).setData(authDict) {_ in }
        
        ProfileService.delfollowingId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
            
        ProfileService.delfollowersId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
    }
    
    func declineFollow(userId: String) {
        ProfileService.delfollowingId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
            
        ProfileService.delfollowersId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
    }
    
    func deleteContact(userId: String) {
        ProfileService.delcontactId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
            
        ProfileService.delcontactfollowersId(userId: userId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
    }
    
    func followEvent(postId: String, currentUserUid: String) {
        
        let post = PostUidModel.init(postId: postId)
        let AuthUser = UidUserModel.init(uid: currentUserUid)
     
        guard let dict = try? post.asDictionary() else {
            return
        }
        
        guard let authDict = try? AuthUser.asDictionary() else {
            return
        }
        
        ProfileService.followingEventId(postId: postId).setData(dict) {_ in}
            
        ProfileService.followersEventId(postId: postId).setData(authDict) {_ in}
    }
    
    func unfollowEvent(postId: String) {
        
        ProfileService.followingEventId(postId: postId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
            
        ProfileService.followersEventId(postId: postId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
            }
        }
    }
}


