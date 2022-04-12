//
//  PostService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 03.01.22.
//

import Foundation
import Firebase
import FirebaseFirestore

class PostService {
    static var posts = AuthService.storeRoot.collection("users")
    static var users = AuthService.storeRoot.collection("users")
    static var allPosts = AuthService.storeRoot.collection("allPosts")
    static var timeline = AuthService.storeRoot.collection("timeline")
    
    static func postsCollection(userId: String) -> CollectionReference {
        return users.document(userId).collection("posts")
    }
    
    static func postUserId(userId: String) -> DocumentReference {
        return posts.document(userId)
    }
    
    static func getPostId(postId: String) -> DocumentReference {
        allPosts.document(postId)
    }
    
    static func userId(userId: String) -> DocumentReference {
        return users.document(userId)
    }
    
    static func postEventId(postId: String) -> DocumentReference {
        return allPosts.document(postId)
    }
    
    static func timelineUserId(userId: String) -> DocumentReference {
        return timeline.document(userId)
    }
    
    static func uploadPost(caption: String, startDate: Date, endDate: Date, index: Int, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_
        errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = PostService.postUserId(userId: userId).collection("posts").document().documentID
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
    
        StorageService.savePostPhoto(userId: userId, caption: caption, index: index, startDate: startDate, endDate: endDate, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
    
    static func loadUserPosts(userId: String, onSuccess: @escaping(_
      posts: [PostModel]) -> Void) {
        PostService.postUserId(userId: userId).collection("posts").order(by: "dateN", descending: true).getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var posts = [PostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? PostModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
    static func loadUser(userId: String, onSuccess: @escaping(_
      users: [UidUserModel]) -> Void) {
        PostService.userId(userId: userId).collection("following").getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var followUsers = [UidUserModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? UidUserModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                followUsers.append(decoder)
            }
            
            onSuccess(followUsers)
        }
    }
    
    static func loadAllUser(userId: String, onSuccess: @escaping(_
      users: [UserModel]) -> Void) {
        PostService.users.getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var users = [UserModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? UserModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                users.append(decoder)
            }
            
            onSuccess(users)
        }
    }
    
    static func loadEventPosts(postId: String, onSuccess: @escaping(_
      posts: [EventPostModel]) -> Void) {
        PostService.postEventId(postId: postId).collection("posts").order(by: "dateN", descending: true).getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var posts = [EventPostModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? EventPostModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
    static func highlightPost(userId: String, postId: String, highlight: Bool, onSuccess: @escaping() -> Void) {
        let firestorePostId = PostService.getPostId(postId: postId)
        let j = PostService.postsCollection(userId: userId)
        let path = j.document(postId)
        
        firestorePostId.updateData([
            "highlighted": highlight,
        ])
        
        path.updateData([
            "highlighted": highlight,
        ])
    }
}
