//
//  ReautheticationView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 26.04.22.
//

import SwiftUI
import Firebase

struct ReautheticationView: View {
    @State var color = Color.black.opacity(0.7)
    
    @Binding var back: Bool
    
    @State var error = "Gebe dein Passwort ein"
    @State var password = ""
    @Binding var email: String
    
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
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    SecureTextEditField(selectedIndex: 2, password: "", header: "Passwort", image: "lock", textField: "********", visible: visible, value: $password)
                    
                    if alert == true {
                        Text("Das Passwort ist falsch")
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
                                
                                self.nextView.toggle()
                                
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
}


    



