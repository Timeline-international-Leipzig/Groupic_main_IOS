//
//  EventFollowService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 25.03.22.
//


import Foundation

class EventFollowService: ObservableObject {
    func updateFollowCount(postId: String, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        EventService.followingCollection(postId: postId).getDocuments {
            (snap, error) in
            
            if let doc = snap?.documents {
                followingCount(doc.count)
            }
        }
        
        EventService.followersCollection(postId: postId).getDocuments {
            (snap, error) in
            
            if let doc = snap?.documents {
                followersCount(doc.count)
            }
        }
    }
    
    func manageFollow(postId: String, followCheck: Bool, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        if !followCheck {
            follow(postId: postId, followingCount: followingCount, followersCount: followersCount)
        } else {
            unfollow(postId: postId, followingCount: followingCount, followersCount: followersCount)
        }
    }
    
    func follow(postId: String, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        EventService.followingId(postId: postId).setData([:]) {
            (err) in
            
            if err == nil {
                self.updateFollowCount(postId: postId, followingCount: followingCount, followersCount: followersCount)
            }
        }
            
        EventService.followersId(postId: postId).setData([:]) {
            (err) in
            
            if err == nil {
                self.updateFollowCount(postId: postId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
        
    func unfollow(postId: String, followingCount: @escaping (_
            followingCount: Int) -> Void, followersCount: @escaping (_
            followersCount: Int) -> Void) {
        
        EventService.followingId(postId: postId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(postId: postId, followingCount: followingCount, followersCount: followersCount)
            }
        }
            
        EventService.followersId(postId: postId).getDocument {
            (document, err) in
            
            if let doc = document, doc.exists {
                doc.reference.delete()
                
                self.updateFollowCount(postId: postId, followingCount: followingCount, followersCount: followersCount)
            }
        }
    }
}


