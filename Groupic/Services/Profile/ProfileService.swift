//
//  ProfileService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 12.01.22.
//

import Foundation
import Firebase
import Combine

class ProfileService: ObservableObject {    
    @Published var posts: [PostModel] = []
    @Published var postsUid: [PostUidModel] = []
    @Published var users: [UserModel] = []
    @Published var usersUid: [UidUserModel] = []
    @Published var followUsers: [UidUserModel] = []
    @Published var eventUsers: [UidUserModel] = []
    @Published var requestsUser: [UidCheckUserModel] = []
    @Published var requestsEventUser: [InviteUidModel] = []
    @Published var followPosts: [PostUidModel] = []
    
    @Published var eventElements: [EventContentModel] = []
    @Published var compositionElements: [[EventContentModel]] = []
    
    @Published var following = 0
    @Published var follower = 0
    
    @Published var followCheck = false
    
    static var follow = AuthService.storeRoot.collection("users")
    
    static var followEvent = AuthService.storeRoot.collection("events")
    
    static func followingCollection(userId: String) -> CollectionReference {
        return follow.document(userId).collection("contactRequest")
    }
    
    static func followersCollection(userId: String) -> CollectionReference {
        return follow.document(userId).collection("contact")
    }
    
    static func followingId(userId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("contactRequest").document(userId)
    }
    
    static func checkfollowingEventId(postId: String, userId: String) -> DocumentReference {
        return follow.document(postId).collection("requestedParticipants").document(userId)
    }
    
    static func followingEventId(postId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("eventRequest").document(postId)
    }
    
    static func InviteIntoEventId(postId: String, userId: String) -> DocumentReference {
        return follow.document(userId).collection("eventRequest").document(postId)
    }
    
    static func acceptInviteIntoEventId(postId: String, userId: String) -> DocumentReference {
        return follow.document(userId).collection("events").document(postId)
    }
    
    static func delfollowingId(userId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("requestsForContact").document(userId)
    }
    
    static func delcontactId(userId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("contact").document(userId)
    }
    
    static func acceptFollowingId(userId: String) -> DocumentReference {
        return follow.document(Auth.auth().currentUser!.uid).collection("contact").document(userId)
    }
    
    static func followersEventId(postId: String) -> DocumentReference {
        return followEvent.document(postId).collection("participants").document(Auth.auth().currentUser!.uid)
    }
    
    static func followersInviteEventId(postId: String, userId: String) -> DocumentReference {
        return followEvent.document(postId).collection("requestedParticipants").document(userId)
    }
    
    static func adminEventId(postId: String, userId: String) -> DocumentReference {
        return followEvent.document(postId).collection("admins").document(userId)
    }
    
    static func acceptFollowersInviteEventId(postId: String, userId: String) -> DocumentReference {
        return followEvent.document(postId).collection("participants").document(userId)
    }
    
    static func followersId(userId: String) -> DocumentReference {
        return follow.document(userId).collection("requestsForContact").document(Auth.auth().currentUser!.uid)
    }
    
    static func delfollowersId(userId: String) -> DocumentReference {
        return follow.document(userId).collection("contactRequest").document(Auth.auth().currentUser!.uid)
    }
    
    static func delcontactfollowersId(userId: String) -> DocumentReference {
        return follow.document(userId).collection("contact").document(Auth.auth().currentUser!.uid)
    }
    
    static func acceptFollowersId(userId: String) -> DocumentReference {
        return follow.document(userId).collection("contact").document(Auth.auth().currentUser!.uid)
    }
    
    static func followersCheck(userId: String) -> CollectionReference {
        return follow.document(userId).collection("requestsForContact")
    }
    
    static func followersEventCheck(userId: String) -> CollectionReference {
        return follow.document(userId).collection("eventRequest")
    }
    
    static func followersPostEventCheck(postId: String) -> CollectionReference {
        return follow.document(postId).collection("participants")
    }
    
    static func contactCheck(userId: String) -> CollectionReference {
        return follow.document(userId).collection("contact")
    }
    
    func followStateUser(userId: String) {
        ProfileService.followingId(userId: userId).getDocument {
            (document, error) in
            
            if let doc = document, doc.exists {
                self.followCheck = true
                }
            else {
                self.followCheck = false
            }
        }
    }
    
    func loadUserPosts(userId: String) {
        PostService.loadUserPosts(userId: userId) {
            (posts) in
            
            self.postsUid = posts
        }
    }
    
    func allPosts(userId: String) {
        PostService.loadAllPosts() {
            (posts) in
            
            self.posts = posts
        }
    }
    
    func loadAllEventElements(postId: String) {
        PostService.loadAllEventElements(postId: postId) {
            (elements) in
            
            self.eventElements = elements
            
            self.loadCompositionElements(postId: postId)
        }
    }
    
    func loadCompositionElements(postId: String) {
        var currentEventElements: [EventContentModel] = []
        
        eventElements.forEach { (card) in
            currentEventElements.append(card)
            
            if card.type == "IMAGE" && currentEventElements.count == 3  {
                self.compositionElements.append(currentEventElements)
                currentEventElements.removeAll()
            }
            
            if  card.id == eventElements.last!.id && currentEventElements.count != 3 {
                self.compositionElements.append(currentEventElements)
                currentEventElements.removeAll()
            }
            
            if card.type == "TEXT" {
                self.compositionElements.append(currentEventElements)
                currentEventElements.removeAll()
            }
        }
    }
    
    func loadUser(userId: String) {
        PostService.loadUser(userId: userId) {
            (users) in
            
            
            self.followUsers = users
        }
    }
    
    func loadtUser(userId: String, postId: String) {
        PostService.loadUser(userId: userId) {
            (users) in
            
            PostService.loadAllEventUserUid(postId: postId) {
                (usersEvent) in
            
                if users == usersEvent {
                }
                else {
                    self.eventUsers = users
                }
            }
        }
    }
    
    func loadRequestUser(userId: String) {
        PostService.loadRequestUser(userId: userId) {
            (users) in
            
            self.requestsUser = users
        }
    }
    
    func loadRequestEvent(userId: String) {
        PostService.loadRequestEvent(userId: userId) {
            (users) in
            
            self.requestsEventUser = users
        }
    }
    
    func loadAllUser(userId: String) {
        PostService.loadAllUser(userId: userId) {
            (users) in
            
            self.users = users
        }
    }
    
    func loadAllEventUsers(postId: String) {
        PostService.loadAllEventUserUid(postId: postId) {
            (users) in
            
            self.usersUid = users
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
