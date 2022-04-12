//
//  SearchService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.03.22.
//

import Foundation
import Firebase

class SearchService {
    static func searchUser(input: String, onSuccess: @escaping (_
        user: [UserModel]) -> Void) {
        
        AuthService.storeRoot.collection("users").whereField("searchName", arrayContains: input.lowercased().removeWhiteSpace())
            .getDocuments {
                (querySnapshot, err) in
                
                guard let snap = querySnapshot else {
                    print("error")
                    return
                }
                
                var users = [UserModel]()
                for document in snap.documents {
                    let dict = document.data()
                    
                    guard let decoded = try? UserModel.init(fromDictionary: dict)
                        else {return}
                    
                    users.append(decoded)
                    
                    onSuccess(users)
                }
            }
    }
}
