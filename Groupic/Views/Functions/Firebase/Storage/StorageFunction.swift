//
//  StorageFunctions.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import Foundation
import Firebase

class StorageFunction {
    static var storage = Storage.storage()
    static var storageRoot = storage.reference(forURL: "gs://groupic-i.appspot.com")
    static var storageProfile = storageRoot.child("profile")
    
    static func storageProfileId(userId: String) -> StorageReference {
        return storageProfile.child(userId)
    }
    
    static func saveProfileImage(userId: String, username: String, email: String, imageData: Data, metaData: StorageMetadata, storageProfileImageRef: StorageReference, onSuccess: @escaping(_ user: User) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        
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
                    
                    let firestoreUserId = AuthFunction.getUserId(userId: userId)
                    let user = User.init(uid: userId, email: email, profileImageUrl: metaImageUrl, userName: username, searchName: username.splitString(), bio: "")
                    
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
    }
}
 
