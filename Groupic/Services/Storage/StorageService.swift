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
    static var storagePost = storageRoot.child("posts")
    
    // Create a StorageReference (Post)
    static func storagePostId(postId: String) -> StorageReference {
        return storagePost.child(postId)
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
                        "userName": username,
                        "name": name,
                        "searchName": username.splitString()
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
                        "userName": username,
                        "name": name,
                        "searchName": username.splitString()
                    ])
                }
            }
        }
    }
    
    static func editProfileAll(userId: String, name: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
            
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
                            "userName": username,
                            "name": name,
                            "searchName": username.splitString()
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
        "searchName": username.splitString()
    ])
}
    
static func savePostPhoto(userId: String, caption: String, index: Int, startDate: Date, endDate: Date, postId: String, imageData: Data, metadata: StorageMetadata, storagePostRef: StorageReference, onSuccess: @escaping() -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
        storagePostRef.putData(imageData, metadata: metadata) {
            (StorageMetadata, error) in
            if error != nil {
                onError(error!.localizedDescription)
                
                return
            }
            
            storagePostRef.downloadURL {
                (url, error) in
                if let metaImageUrl = url?.absoluteString {
                    let firestorePostRef = PostService.postUserId(userId: userId).collection("posts").document(postId)
                    
                    let post = PostModel.init(highlighted: false, dateN: Date().timeIntervalSince1970, caption: caption,index: index, likes: [:], geoLocation: "", ownerId: userId, postId: postId, username:Auth.auth().currentUser!.displayName!, profile: Auth.auth().currentUser!.photoURL!.absoluteString,mediaUrl: metaImageUrl, startDate: startDate, endDate: endDate, likeCount: 0)
                    
                    guard let dict = try? post.asDictionary() else {
                        return
                    }
                    
                    firestorePostRef.setData(dict) {_ in
                        if error != nil {
                            onError(error!.localizedDescription)
                            
                            return
                        }
                        
                        PostService.allPosts.document(postId).setData(dict)
                        onSuccess()
                    }
                }
            }
        }
    }
}
