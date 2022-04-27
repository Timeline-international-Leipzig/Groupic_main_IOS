//
//  ReEmailView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27.04.22.
//

import SwiftUI
import Firebase

struct ReEmailView: View {
    var userCollection = Firestore.firestore().collection("users")
    
    @State var color = Color.black.opacity(0.7)
    
    @Binding var back: Bool
    
    @State var error = "Gebe deine neue E-Mail und dein Passwort ein"
    @State var password = ""
    @State var email = ""
    
    @State var closetitle = "Schließen"
    
    @State var visible = false
    @State var nextView = false
    @State var alert = false
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    TextEditField(selectedIndex: 0, header: "E-Mail", image: "mail", textField: "", value: $email)
                    
                    SecureTextEditField(selectedIndex: 2, password: "", header: "Passwort", image: "lock", textField: "********", visible: visible, value: $password)
                    
                    if alert == true {
                        Text("Das Passwort oder die E-Mail sind falsch")
                            .foregroundColor(Color.red)
                            .padding(.top)
                            .padding(.horizontal, 25)
                    } else {}
                    
                    Button(action: {
                        if alert == false {
                            let credential: AuthCredential = EmailAuthProvider.credential(withEmail: (Auth.auth().currentUser?.email)!, password: password)
                        
                            guard let userId = Auth.auth().currentUser?.uid
                            else {
                                return
                            }
                        
                            if isValidEmail(email) == false {
                                self.error = "Keine valide E-Mail-Form"
                              
                                if alert == false {
                                self.alert = true
                                }
                            }
                            else {
                                checkIfEmailOfAccountExists { result in
                                    if (result == true) {
                                        self.error = "Diese E-Mail existiert bereits! \n Wähle bitte eine neue E-Mail"
                                        if alert == false {
                                        self.alert = true
                                        }
                                    }
                                    
                                    else {
                                        if let error = errorCheck() {
                                            self.error = error
                                            if alert == false {
                                            self.alert = true
                                            }

                                        }
                                        else {
                                            Auth.auth().currentUser?.reauthenticate(with: credential) {(authData, error) in
                                                if error != nil {
                                                    self.alert = true
                                                    return
                                                } else {
                                                    StorageService.editProfileTextEmail(userId: userId, email: email, onSuccess: {
                                                    })
                                                    
                                                        Auth.auth().currentUser?.reload(completion: { (err) in
                                                            Auth.auth().currentUser?.sendEmailVerification { error in
                                                            }
                                                        })
                                                    
                                                    self.back.toggle()
                                                    
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                            

                        }
                        else {
                            self.alert = false
                        }
                    }, label: {
                        if alert == false {
                        Text("E-Mail ändern")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                        }
                        else {
                            Text("Alles klar")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 120)
                        }
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                    
                    Button(action: {
                        self.back.toggle()
                    }, label: {
                        Text("Schließen")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .padding(.all, 25)
                .frame(width: UIScreen.main.bounds.width - 90)
                .background(Color.white.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
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
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func errorCheck() -> String? {
        if  email.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty {

            return "Fülle bitte alle Felder aus"
        }
        
        return nil
    }
}


    


