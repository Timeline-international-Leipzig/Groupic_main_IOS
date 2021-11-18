//
//  LoginView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27/09/2021.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var color = Color.black
    @State private var email = ""
    @State private var password = ""
    @State var visible = false
    @State var alert = false
    
    ///Anderer Platz
    @State var error = ""
    @State var errortitle = ""
    @State var closetitle = ""
    
    @Binding var viewState: Bool
    
    var body: some View {
        ZStack {
            GeometryReader {_ in
                VStack {
                    Image("glogo-nb")
                        .resizable()
                        .scaledToFill()
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        .frame(width: 80, height: 80)
                
                    LoginRegisterField(header: "E-Mail", image: "mail", textField: "groupic@mail.com", field: true, visible: visible, color: color, value: $email)
                    
                    LoginRegisterField(header: "Passwort", image: "lock", textField: "********", visible: visible, color: color, value: $password)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                          
                        }, label: {
                            Text("Passwort vergessen?")
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                        })
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                    
                    LoginButton(email: $email, password: $password, error: $error, alert: $alert, viewState: $viewState)
                    
                }
                .background(Color.white.opacity(0.75))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                .padding()
            }
            .background(
                Image("login-b")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error, errortitle: $errortitle, closetitle: $closetitle)
            }
        }
    }
}

