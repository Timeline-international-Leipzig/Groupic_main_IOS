//
//  LoginButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 11/10/2021.
//

import SwiftUI
import Firebase

struct LoginButton: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var error: String
    @Binding var alert: Bool
    @Binding var viewState: Bool
    
    var body: some View {
        VStack {
                Button(action: {
                    self.verify()
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
    
    func verify() {
        if self.email != "" && self.password != "" {
            Auth.auth().signIn(withEmail: self.email, password: self.password) { (res,err) in
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                UserDefaults.standard.set(true, forKey: "status")
                NotificationCenter.default.post(name: NSNotification.Name("status"), object: nil)
            }
        }
        else {
            self.error = "Es wurde nicht alles ausgefüllt"
            self.alert.toggle()
        }
    }
    
    func reset() {
        if self.email != "" {
            Auth.auth().sendPasswordReset(withEmail: self.email) {(err) in
                if err != nil {
                    self.error = err!.localizedDescription
                    self.alert.toggle()
                    return
                }
                
                self.error = "Passwort wurde zurückgesetzt"
                self.alert.toggle()
            }
        }
        else {
            self.error = "Es wurde keine E-Mail angegeben"
            self.alert.toggle()
        }
    }
}



