//
//  LoginRegisterButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI
import Firebase

struct RegisterButton: View {
    
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    @Binding var error: String
    @Binding var alert: Bool
    @Binding var viewState: Bool
    
    var body: some View {
        VStack {
                Button(action: {
                    self.register()
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
    
    // Register
    func register() {
        if self.email != "" {
            if self.password == self.repassword {
                Auth.auth().createUser(withEmail: self.email, password: self.password) {(res,err) in
                    if err != nil {
                        self.error = err!.localizedDescription
                        self.alert.toggle()
                        return
                    }
                    
                    UserDefaults.standard.setValue(true, forKey: "status")
                    NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
                }
            }
            else {
                self.error = "Passwörter stimmen nicht überein"
                self.alert.toggle()
            }
        }
        else {
            self.error = "Es wurde nicht alles ausgefüllt"
            self.alert.toggle()
        }
    }
}
