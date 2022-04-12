//
//  RegistrationService.swift
//  Groupic
//
//  Created by Anatolij Travkin on 06.04.22.
//

import Combine
import Foundation
import Firebase

enum RegistrationKeys: String {
    case uid
    case email
    case password
    case profileImageUrl
    case backgroundImageUrl
    case name
    case userName
    case searchName
}

final class RegistrationService: RegistrationProtocol {
    
    func register(with credentials: UserModel) -> AnyPublisher<Void, Error> {
        Deferred {
            Future { promise in
                Auth.auth().createUser(withEmail: credentials.email,
                                       password: credentials.password) { res, error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid {
                            
                            let values = [RegistrationKeys.uid.rawValue: credentials.uid,
                                          RegistrationKeys.email.rawValue: credentials.email,
                                          RegistrationKeys.password.rawValue: credentials.password,
                                          RegistrationKeys.profileImageUrl.rawValue: credentials.profileImageUrl,
                                          RegistrationKeys.backgroundImageUrl.rawValue: credentials.backgroundImageUrl,
                                          RegistrationKeys.name.rawValue: credentials.name,
                                          RegistrationKeys.userName.rawValue: credentials.userName,
                                          RegistrationKeys.searchName.rawValue: credentials.searchName,
                            
                            let storageProfileUserId = StorageService.storageProfileId(userId: userId)
                                          
                                          let firestoreUserId = AuthService.getUserId(userId: userId)
                                          let user = UserModel.init(uid: userId, email: email, profileImageUrl: metaImageUrl, backgroundImageUrl: metaImageUrl, name: name, userName: username, searchName: username.splitString())
                                       
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
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        }
    }
}
