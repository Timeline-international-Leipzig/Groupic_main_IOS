//
//  ReautheticationPasswordView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 28.04.22.
//

import SwiftUI
import Firebase

struct ReautheticationPasswordView: View {
    @State var color = Color.black.opacity(0.7)
    
    @Binding var back: Bool
    
    @State var error = "Gebe dein altes und neues Passwort ein."
    @State var errorVar = ""
    @State var password = ""
    @State var newpassword = ""
    @State var renewpassword = ""
    
    @State var closetitle = "Schließen"
    
    @State var visible = false
    @State var nextView = false
    @State var alert = false
    
    var body: some View {
        NavigationLink(destination: VerificationReauthetificationView(), isActive: self.$nextView, label: {
            EmptyView()
        })
        
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    SecureTextEditField(selectedIndex: 2, password: "", header: "Altes Passwort", image: "lock", textField: "********", visible: visible, value: $password)
                    
                    SecureTextEditField(selectedIndex: 1, password: "", header: "Neues Passwort", image: "lock", textField: "********", visible: visible, value: $newpassword)
                    
                    SecureTextEditField(selectedIndex: 0, password: newpassword, header: "Wiederhole dein Passwort", image: "lock", textField: "********", visible: visible, value: $renewpassword)
                    
                    if alert == true {
                        Text(errorVar)
                            .foregroundColor(Color.red)
                            .padding(.top)
                            .padding(.horizontal, 25)
                    } else {}
                    
                    Button(action: {
                        if alert == false {
                            let credential: AuthCredential = EmailAuthProvider.credential(withEmail: (Auth.auth().currentUser?.email)!, password: password)
                        
                        Auth.auth().currentUser?.reauthenticate(with: credential) {(authData, error) in
                            if error != nil {
                                errorVar = "Dein altes Passwort stimmt nicht"
                                self.alert = true
                                return
                            } else {
                                if newpassword == renewpassword {
                                    Auth.auth().currentUser?.updatePassword(to: newpassword) { error in
                                      // ...
                                    }
                                    
                                    self.back.toggle()
                                }
                                else {
                                    errorVar = "Die neuen Passwörter stimmen nicht überein!"
                                    self.alert = true
                                    return
                                }
                                
                                }
                            }
                        }
                        else {
                            self.alert = false
                        }
                    }, label: {
                        if alert == false {
                        Text("Password ändern")
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
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(Color.black.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
}


    
