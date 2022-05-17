//
//  StorageService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 23.11.21.
//
import Foundation
import Firebase

class StorageService {
    static var storage = Storage.storage()
    static var storageRoot = storage.reference()
    static var storageProfile = storageRoot.child("profiles")
    static var storagePost = storageRoot.child("events")
    
    // Create a StorageReference (Post)
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
    }
    
    static func storagePostEventId(postId: String, eventId: String) -> StorageReference {
        return storagePost.child(postId).child("elements").child(eventId)
    }
    
    // Create a StorageReference (Profile)
    static func storageProfileId(userId: String) -> StorageReference {
        return storageProfile.child("profilePicture").child(userId)
    }
    
    static func storageBackProfileId(userId: String) -> StorageReference {
        return storageProfile.child("profileBackPicture").child(userId)
    }
    
    static func saveProfileImage(userId: String, name: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
        }
            
            storageProfileImageRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges {
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                
                                return
                            }
                        }
                    }
                    
                    
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    let user = UserModel.init(uid: userId, email: email, profileImageUrl: metaImageUrl, backgroundImageUrl: "", name: name, userName: username, searchName: username.splitString())
                 
                    guard let dict = try? user.asDictionary() else {
                        return
                    }
                     
                    firestoreUserId.setData(dict) {
                        (error) in
                        if error != nil {
                            onError(error!.localizedDescription)
                        }
                    }
                    
                    onSuccess(user)
                }
            }
        }
    
    static func saveProfile(userId: String, name: String, username: String, email: String, onSuccess: @escaping(_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
                    
            let firestoreUserId = AuthService.getUserId(userId: userId)
            let user = UserModel.init(uid: userId, email: email, profileImageUrl: "", backgroundImageUrl: "", name: name, userName: username, searchName: username.splitString())
        
            
            
            guard let dict = try? user.asDictionary() else {
                return
            }
                
            firestoreUserId.setData(dict) {
                (error) in
                if error != nil {
                    onError(error!.localizedDescription)
                }
            }
            
            onSuccess(user)
        }

    
static func editProfile(userId: String, name: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
        
            storageProfileImageRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges {
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    
                    firestoreUserId.updateData([
                        "profileImageUrl": metaImageUrl,
                    ])
                }
            }
        }
    }
    
static func editBackProfile(userId: String, name: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storageProfileImageRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
        
            storageProfileImageRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest() {
                        changeRequest.photoURL = url
                        changeRequest.displayName = username
                        changeRequest.commitChanges {
                            (error) in
                            if error != nil {
                                onError(error!.localizedDescription)
                                
                                return
                            }
                        }
                    }
                    
                    let firestoreUserId = AuthService.getUserId(userId: userId)
                    
                    firestoreUserId.updateData([
                        "backgroundImageUrl": metaImageUrl,
                    ])
                }
            }
        }
    }
    
static func editProfileText(userId: String, name: String, username: String, email: String, onSuccess: @escaping() -> Void) {
    let firestoreUserId = AuthService.getUserId(userId: userId)
    
    firestoreUserId.updateData([
        "userName": username,
        "name": name,
        "searchName": username.splitString(),
        "email": email
    ])
    
    Auth.auth().currentUser?.updateEmail(to: email) { error in
      // ...
    }
}
    
static func editProfileTextEmail(userId: String, email: String, onSuccess: @escaping() -> Void) {
    let firestoreUserId = AuthService.getUserId(userId: userId)
    
    let userEmail = Auth.auth().currentUser?.email
    
    firestoreUserId.updateData([
        "email": email,
    ])
    
    if email != userEmail {
        Auth.auth().currentUser!.updateEmail(to: email) { error in
          
            if let error = error {
            print(error)
            }
        }
    }
}
    
static func editProfileTextName(userId: String, name: String, onSuccess: @escaping() -> Void) {
    let firestoreUserId = AuthService.getUserId(userId: userId)
    
    firestoreUserId.updateData([
        "name": name,
    ])
}
    
static func editProfileTextUsername(userId: String, username: String, onSuccess: @escaping() -> Void) {
    let firestoreUserId = AuthService.getUserId(userId: userId)
    
    firestoreUserId.updateData([
        "userName": username,
        "searchName": username.splitString(),
    ])
}
    
/// Post-Functions
    static func savePostPhoto(userId: String, username: String, caption: String, index: Int, startDate: Date, endDate: Date, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
            
            storagePostRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef =  PostService.allPosts.document(postId)
                    let firestorePostRefUid = PostService.postUserId(userId: userId).collection("events").document(postId)
                    let firestorePostRefUserUid =  PostService.allPosts.document(postId).collection("participants").document(userId)
                    
                    let post = PostModel.init(highlighted: false, dateN: Date().timeIntervalSince1970, caption: caption,index: index, likes: [:], geoLocation: "", ownerId: userId, postId: postId, username: username, mediaUrl: metaImageUrl, startDate: startDate, endDate: endDate, likeCount: 0)
                    
                    let postUid = PostUidModel.init(postId: postId)
                    
                    let userUid = UidUserModel.init(uid: userId)
                    
                    guard let dict = try? post.asDictionary() else {
                        return
                    }
                    
                    guard let dictUserUid = try? userUid.asDictionary() else {
                        return
                    }
                    
                    guard let dictUid = try? postUid.asDictionary() else {
                        return
                    }
                    
                    firestorePostRef.setData(dict) {_ in
                        if error != nil {
                            onError(error!.localizedDescription)
                            
                            return
                        }
        
                        firestorePostRefUid.setData(dictUid)
                        firestorePostRefUserUid.setData(dictUserUid)
                        onSuccess()
                    }
                }
            }
        }
    }
    
    static func editPost(postId: String, userId: String, imageData: Data, metaData: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
            
        storagePostRef.putData(imageData, metadata: metaData) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
                
                storagePostRef.downloadURL {
                    (url, error) in
                    if let metaImageUrl = url?.absoluteString {
                        let firestorePostRef = PostService.allPosts.document(postId)
                        let firestorePostRefUser = PostService.posts.document(userId).collection("posts").document(postId)
                        
                        firestorePostRef.updateData([
                            "mediaUrl": metaImageUrl,
                        ])
                        
                        firestorePostRefUser.updateData([
                            "mediaUrl": metaImageUrl,
                        ])
                    }
                }
            }
        }
    
    static func editPostTextTitle(userId: String, postId: String, caption: String, onSuccess: @escaping() -> Void) {
        let firestorePostRef = PostService.allPosts.document(postId)
        
        firestorePostRef.updateData([
            "caption": caption,
        ])
    }
    
    static func editPostMode(userId: String, postId: String, index: Int, onSuccess: @escaping() -> Void) {
        let firestorePostRef = PostService.allPosts.document(postId)
        
        firestorePostRef.updateData([
            "index": index,
        ])
    }
    
    static func deletePost(userId: String, postId: String, onSuccess: @escaping() -> Void) {
        let firestorePostRef = PostService.allPosts.document(postId)
        let storagePostRef = StorageService.storagePostId(postId: postId)
        
        firestorePostRef.delete()
        
        storagePostRef.delete()
    }
    
    /// Event-Functions
    static func saveEventPhoto(userId: String, username: String, userPicture: String, stamp: Date, postId: String, eventId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
            
            storagePostRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef =  PostService.allPosts.document(postId).collection("elements").document(eventId)
                    let post = EventContentModel.init(id: eventId, stamp: stamp, text: "", type: "IMAGE", uriOrUid: metaImageUrl, userUid: userId)
                    
                    guard let dict = try? post.asDictionary() else {
                        return
                    }
                    
                    firestorePostRef.setData(dict) {_ in
                        if error != nil {
                            onError(error!.localizedDescription)
                            
                            return
                        }
                        
                        onSuccess()
                    }
                }
            }
        }
    }
    
    static func saveEventQuote(userId: String, text: String, username: String, userPicture: String, stamp: Date, postId: String, eventId: String, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
                    let firestorePostRef =  PostService.allPosts.document(postId).collection("elements").document(eventId)
        let post = EventContentModel.init(id: eventId, stamp: stamp, text: text, type: "TEXT", uriOrUid: "", userUid: userId)
                    
                    guard let dict = try? post.asDictionary() else {
                        return
                    }
                    
                    firestorePostRef.setData(dict) {_ in
                        onSuccess()
                    }
                

        }
    }

