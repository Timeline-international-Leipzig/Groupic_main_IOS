//
//  RegisterButtonTest.swift
//  Groupic
//
//  Created by Anatolij Travkin on 06.04.22.
//

import SwiftUI
import Firebase

struct RegisterButtonNoPictures: View {
    @StateObject var profileService = ProfileService()
    
    var userCollection = Firestore.firestore().collection("users")
    @State var userHasAccount = false
    
    @State var errorCheckBool = false
    @State var allowed: CharacterSet = .alphanumerics
    
    @Binding var name: String
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    
    @Binding var error: String
    @Binding var alert: Bool
    @Binding var next: Bool
    @Binding var checked: Bool
    
    @Binding var viewState: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                if let error = errorCheck() {
                    self.error = error
                    self.alert.toggle()
                    self.clear()
                    return
                }
                
                checkIfUsernameOfAccountExists { result in
                    if (result == true) {
                        self.userHasAccount = true
                        self.error = "Dieser Username existiert bereits! \n Bitte wähle einen neuen Username"
                        self.alert.toggle()
                    }
                    else {
                        if checked == true {
                        self.userHasAccount = false
                        self.signUp()
                        }
                        else {
                            self.error = "Du musst mit der AGB sowie dem Datenschutz einverstanden sein!"
                            self.alert.toggle()
                        }
                    }
                }
            }, label: {
                Text("Registrierung")
                    .foregroundColor(.white)
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            })
            .background(Color("AccentColor"))
            .cornerRadius(10)
            .padding(.bottom, 25)
            .padding(.horizontal, 10)
        
            HStack {
                Text("Bereits Nutzer?")
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
                
                Button(action: {
                    self.viewState.toggle()
                }, label: {
                    Text("Einloggen")
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                })
            }
            .padding(.bottom, 20)
        }
        .padding(.top, 45)
    }
    
    /// Functions
    func checkIfUsernameOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("userName", isEqualTo: self.username).getDocuments() {
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
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.alert.toggle()
            self.clear()
            return
        }
        
        AuthService.signUpNoPictures(name: name, username: username, email: email, password: password, onSuccess: {
            (user) in
            
            Auth.auth().currentUser?.sendEmailVerification { error in
                self.error = "Es ist ein Fehler aufgetreten"
                self.alert.toggle()
            }
            
            self.next.toggle()
        }) {
            (errorMessage) in
            self.error = errorMessage
            self.alert.toggle()
        }
    }
    
    func errorCheck() -> String? {
        if  name.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty {
            
            if  name.count > 20 {
                
                return "Der Name ist zu lang! [Unter 20 Zeichen]"
            }
            
            if  checked == false {
                
                return "Du musst mit dem Datenschutz sowie unserer AGB einverstanden sein!"
            }
            
            if  username.count > 8 {
                
                return "Der Username ist zu lang! [Unter 8 Zeichen]"
            }
            
            return "Fülle bitte alle Felder aus"
        }
        
        return nil
    }
    
    func clear() {
        self.name = ""
        self.username = ""
    }
}
