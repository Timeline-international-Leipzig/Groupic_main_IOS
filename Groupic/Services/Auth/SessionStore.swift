//
//  SessionStore.swift
//  Groupic
//
//  Created by Anatolij Travkin on 11/10/2021.
//

import Foundation
import Combine
import Firebase

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject <SessionStore, Never>()
    @Published var session: UserModel? {didSet{self.didChange.send(self)}}
    var handle: AuthStateDidChangeListenerHandle?
    
    // SignIn Check
    func listen() {
        handle = Auth.auth().addStateDidChangeListener({
            (auth, user) in
            if let user = user {
                let firestoreUserId = AuthService.getUserId(userId: user.uid)
                firestoreUserId.getDocument{
                    (document, error) in
                    if let dict = document?.data() {
                        guard let decodedUser = try? UserModel.init(fromDictionary: dict) else { return }
                        
                        self.session = decodedUser
                    }
                }
            }
            
            else {
                self.session = nil
            }
        })
    }
    
    // LogOut
    func logout() {
        do {
            try Auth.auth().signOut()
        }
        
        catch {
        }
    }
    
    // Stop
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    deinit {
        unbind()
    }
}
