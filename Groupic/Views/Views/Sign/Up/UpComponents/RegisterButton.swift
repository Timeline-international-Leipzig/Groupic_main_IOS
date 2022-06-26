//
//  LoginRegisterButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI
import Firebase

struct RegisterButton: View {
    @EnvironmentObject var session: SessionStore
    
    @State var errortitle = ""
    @State var closetitle = ""
    
    @Binding var name: String
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    @Binding var profileImage: Image?
    
    @Binding var imageData: Data
    
    @Binding var error: String
    @Binding var alert: Bool
    
    @Binding var viewState: Bool
    
    var body: some View {
        VStack {
                Button(action: {
                    self.signUp()
                }, label: {
                    Text("Registrierung")
                        .font(.custom("Inter-Regular", size: 22))
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
    func errorCheck() -> String? {
        if  email.trimmingCharacters(in: .whitespaces).isEmpty ||
            name.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty ||
            password.trimmingCharacters(in: .whitespaces).isEmpty ||
            
            imageData.isEmpty {
            return "Fülle bitte alle Felder aus"
        }
        return nil
    }
    
    func clear() {
        self.email = ""
        self.name = ""
        self.username = ""
        self.password = ""
        self.imageData = Data()
        self.profileImage = Image(systemName: "person.circle.fill")
    }
    
    func signUp() {
        if let error = errorCheck() {
            self.error = error
            self.alert.toggle()
            return
        }
        
        AuthService.signUp(name: name, username: username, email: email, password: password, imageData: imageData, onSuccess: {
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
