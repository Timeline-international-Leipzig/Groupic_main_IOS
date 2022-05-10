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
    static var allPosts = AuthService.storeRoot.collection("events")
    
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
    
    static func uploadPost(caption: String, username: String, startDate: Date, endDate: Date, index: Int, imageData: Data, onSuccess: @escaping() -> Void, onError: @escaping(_
        errorMessage: String) -> Void) {
        
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let postId = PostService.postUserId(userId: userId).collection("events").document().documentID
        let storagePostRef = StorageService.storagePostId(postId: postId)
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
    
        StorageService.savePostPhoto(userId: userId, username: username, caption: caption, index: index, startDate: startDate, endDate: endDate, postId: postId, imageData: imageData, metadata: metadata, storagePostRef: storagePostRef, onSuccess: onSuccess, onError: onError)
    }
        
    static func loadUserPosts(userId: String, onSuccess: @escaping(_
      posts: [PostUidModel]) -> Void) {
        PostService.postUserId(userId: userId).collection("events").getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var posts = [PostUidModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? PostUidModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
    static func loadAllPosts(onSuccess: @escaping(_
      posts: [PostModel]) -> Void) {
        PostService.allPosts.order(by: "dateN", descending: true).getDocuments {
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
    
    static func loadAllEventElements(postId: String, onSuccess: @escaping(_
      posts: [EventContentModel]) -> Void) {
        PostService.allPosts.document(postId).collection("elements").order(by: "stamp", descending: true).getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var posts = [EventContentModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? EventContentModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                posts.append(decoder)
            }
            
            onSuccess(posts)
        }
    }
    
    static func loadPictureEventElements(postId: String, onSuccess: @escaping(_
      posts: [EventContentModel]) -> Void) {
        PostService.allPosts.document(postId).collection("elements").order(by: "stamp", descending: true).getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var posts = [EventContentModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? EventContentModel.init(fromDictionary: dict)
                        
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
    
    static func loadAllEventUserUid(postId: String, onSuccess: @escaping(_
      users: [UidUserModel]) -> Void) {
        PostService.allPosts.document(postId).collection("participants").getDocuments {
            (snapShot, error) in
            
            guard let snap = snapShot else {
                print("Error")
                return
            }
            
            var users = [UidUserModel]()
            
            for doc in snap.documents {
                let dict = doc.data()
                guard let decoder = try? UidUserModel.init(fromDictionary: dict)
                        
                else {
                    return
                }
                
                users.append(decoder)
            }
            
            onSuccess(users)
        }
    }
    
    static func highlightPost(userId: String, postId: String, highlight: Bool, onSuccess: @escaping() -> Void) {
        let firestorePostId = PostService.getPostId(postId: postId)
        
        firestorePostId.updateData([
            "highlighted": highlight,
        ])
    }
}
