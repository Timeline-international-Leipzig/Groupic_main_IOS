//
//  AuthService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 23.11.21.
//

import Foundation
import Firebase

class AuthService {
    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        storeRoot.collection("users").document(userId)
    }
    
    static func signUp(name: String, username: String, email: String, password: String, imageData: Data, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (authData, error) in
            guard let userId = authData?.user.uid else {return}
            
            let storageProfileUserId = StorageService.storageProfileId(userId: userId)
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            
            StorageService.saveProfileImage(userId: userId, name: name, username: username, email: email, imageData: imageData, metaData: metadata, storageProfileImageRef: storageProfileUserId, onSuccess: onSuccess, onError: onError)
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
        }
    }
    
    static func signUpNoPictures(name: String, username: String, email: String, password: String, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) {
            (authData, error) in
            guard let userId = authData?.user.uid
                else {return}
            
            StorageService.saveProfile(userId: userId, name: name, username: username, email: email, onSuccess: onSuccess, onError: onError)
            
            if error != nil {
                onError(error!.localizedDescription)
                return
            }
        }
    }
    
    static func signIn(email: String, password: String, onSuccess: @escaping (_ user: UserModel) -> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) {
            (authData, error) in
            guard let userId = authData?.user.uid else {return}
            
            let firestoreUserID = getUserId(userId: userId)
            
            firestoreUserID.getDocument {
                (document, error) in
                if let dict = document?.data() {
                    guard let decodedUser = try? UserModel.init(fromDictionary: dict) else {return}
                    
                    onSuccess(decodedUser)
                }
            }
            
            if error != nil {
                onError("Das Passwort oder die E-Mail sind falsch!")
                return
            }
        }
    }
}
