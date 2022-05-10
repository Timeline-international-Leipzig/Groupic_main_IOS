//
//  EventService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 25.03.22.
//

import Foundation
import Firebase

class EventService: ObservableObject {
    @Published var following = 0
    @Published var follower = 0
    
    @Published var followCheck = false
    
    static var eventFollowers = AuthService.storeRoot.collection("allPosts")
    static var userFollowingEvents = AuthService.storeRoot.collection("users")
    
    static func followingCollection(postId: String) -> CollectionReference {
        return userFollowingEvents.document(postId).collection("eventFollowing")
    }
    
    static func followersCollection(postId: String) -> CollectionReference {
        return eventFollowers.document(postId).collection("followers")
    }
    
    static func followingId(postId: String) -> DocumentReference {
        return userFollowingEvents.document(Auth.auth().currentUser!.uid).collection("eventFollowing").document(postId)
    }
    
    static func followersId(postId: String) -> DocumentReference {
        return eventFollowers.document(postId).collection("followers").document(Auth.auth().currentUser!.uid)
    }
    
    /// Funktion: Check if the user is already following the event
    func followState(postId: String) {
        EventService.followingId(postId: postId).getDocument {
            (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = true
                }
            else {
                self.followCheck = false
            }
        }
    }

    
    /// Count of following
    func follows(postId: String) {
        EventService.followingCollection(postId: postId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.following = doc.count
            }
        }
    }
    
    /// Count of follower
    func followsm(postId: String) {
        EventService.followersCollection(postId: postId).getDocuments {
            (querysnapshot, err) in
            
            if let doc = querysnapshot?.documents {
                self.follower = doc.count
            }
        }
    }
}
