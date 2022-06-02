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
    @Binding var checkedSecond: Bool
    
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
                        self.error = "Dieser Username existiert bereits! \n Bitte wähle einen neuen Usernamen"
                        self.alert.toggle()
                    }
                    else {
                        if checked == true && checkedSecond == true {
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
                Text("account schon vorhanden?")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                Button(action: {
                    self.viewState.toggle()
                }, label: {
                    Text("anmelden.")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                })
            }
            .padding(.bottom, 20)
        }
        .padding(.top, 45)
    }
    
    /// Functions
    func checkIfUsernameOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("username", isEqualTo: self.username).getDocuments() {
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
            
            Auth.auth().currentUser?.reload(completion: { (err) in
                Auth.auth().currentUser?.sendEmailVerification { error in
                }
            })
            
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
            
            return "Fülle bitte alle Felder aus"
        }
        
        if  name.count > 20 {
            
            return "Der Name ist zu lang! [Unter 20 Zeichen]"
        }
        
        if  username.count > 15 {
            
            return "Der Username ist zu lang! [Unter 15 Zeichen]"
        }
        
        if  username.count < 4 {
            
            return "Der Username ist zu kurz! [Über 4 Zeichen]"
        }
        
        return nil
    }
    
    func clear() {
        self.name = ""
        self.username = ""
    }
}
