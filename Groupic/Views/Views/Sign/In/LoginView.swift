//
//  LoginView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27/09/2021.
//

import SwiftUI
import Firebase

struct LoginView: View {
    @State var next = false
    @State var forgotPassword = false
    @State var visible = false
    @State var alert = false
    
    @State private var email = ""
    @State private var password = ""

    @State var error = "Es ist etwas schief gelaufen beim Einlogge, versuch es nochmal!"
        
    var body: some View {
        ZStack {
            GeometryReader {_ in
                NavigationLink(destination: RegistrationView(back: $next), isActive: self.$next, label: {
                    EmptyView()
                })
                
                NavigationLink(destination: ForgotPasswrdView(forgotPassword: $forgotPassword), isActive: self.$forgotPassword, label: {
                    EmptyView()
                })
                
                VStack {
                    Image("glogo-nb")
                        .resizable()
                        .scaledToFill()
                        .padding(.horizontal, 25)
                        .padding(.top, 25)
                        .frame(width: 80, height: 80)
                
                    TextEditField(selectedIndex: 3, header: "E-Mail", image: "mail", textField: "Deine E-Mail", value: $email)
                    
                    SecureTextEditField(selectedIndex: 2, password: "", header: "Passwort", image: "lock", textField: "Dein Passwort", visible: visible, value: $password)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.forgotPassword.toggle()
                        }, label: {
                            Text("Passwort vergessen?")
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                        })
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                    
                    LoginButton(email: $email, password: $password, error: $error, alert: $alert, viewState: $next)
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
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}

