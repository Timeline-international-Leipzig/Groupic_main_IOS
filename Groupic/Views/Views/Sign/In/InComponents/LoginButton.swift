//
//  LoginButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 11/10/2021.
//

import SwiftUI
import Firebase

struct LoginButton: View {
    @EnvironmentObject var session: SessionStore

    var userCollection = Firestore.firestore().collection("users")
    @State var userHasAccount = false
    
    @Binding var email: String
    @Binding var password: String
    
    @Binding var error: String
    @Binding var alert: Bool
    
    @Binding var viewState: Bool
    
    var body: some View {
        VStack {
                Button(action: {
                    checkIfEmailOfAccountExists { result in
                        if (result == true) {
                            if Auth.auth().currentUser?.isEmailVerified != true {
                                self.error = "Verifiziere bitte erst deine E-Mail"
                                self.alert.toggle()
                            } else {
                                self.error = "Dein Passwort stimmt nicht"
                                self.alert.toggle()
                            }
                        }
                        else {
                            self.signIn()
                            
                            if session.session == nil {
                                self.error = "Deine E-Mail oder Passwort stimmen nicht"
                                self.alert.toggle()
                            }
                        }
                    }
                }, label: {
                    Text("Einloggen")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                })
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .padding(.bottom, 25)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("Neuer Nutzer?")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        self.viewState.toggle()
                    }, label: {
                        Text("Registrierung")
                            .fontWeight(.bold)
                            .foregroundColor(Color("AccentColor"))
                    })
                }
                .padding(.bottom, 20)
            }
            .padding(.top, 35)
    }
    
    func checkIfEmailOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("email", isEqualTo: self.email).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is already a user with this email")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
    
    func errorCheck() -> String? {
        if  email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "Fülle bitte alle Felder aus"
        }
        
        return nil
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
    
    func signIn() {
        if let error = errorCheck() {
            self.error = error
            self.alert.toggle()
            return
        }
        
        AuthService.signIn(email: email, password: password, onSuccess: {
            (user) in
            
            self.clear()
        }) {
            (errorMessage) in
            self.error = errorMessage
            self.alert.toggle()
            return
        }
    }
}



