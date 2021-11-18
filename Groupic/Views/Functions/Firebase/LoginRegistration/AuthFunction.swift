//
//  AuthFunctions.swift
//  Groupic
//
//  Created by Anatolij Travkin on 05/10/2021.
//

import Foundation
import Firebase

class AuthFunction {

    static var storeRoot = Firestore.firestore()
    
    static func getUserId(userId: String) -> DocumentReference {
        storeRoot.collection("users").document(userId)
    }
    
    
}
