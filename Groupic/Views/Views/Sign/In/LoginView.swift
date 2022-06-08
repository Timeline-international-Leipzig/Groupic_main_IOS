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
    @State var alertEmailVerification = false
    
    @State private var email = ""
    @State private var password = ""
    
    @State var error = "Es ist etwas schief gelaufen beim Einlogge, versuch es nochmal!"
    
    var body: some View {
        ZStack {
            NavigationLink(destination: RegistrationView(back: $next), isActive: self.$next, label: {
                EmptyView()
            })
            
            NavigationLink(destination: ForgotPasswrdView(forgotPassword: $forgotPassword), isActive: self.$forgotPassword, label: {
                EmptyView()
            })
            
            ScrollView {
                VStack {
                    /*Image("glogo-nb")
                     .resizable()
                     .scaledToFill()
                     .padding(.horizontal, 25)
                     .padding(.top, 25)
                     .frame(width: 80, height: 80)*/
                    
                    TextEditField(selectedIndex: 3, header: "E-Mail", image: "mail", textField: "", value: $email)
                    
                    SecureTextEditField(selectedIndex: 2, password: "", header: "Passwort", image: "lock", textField: "", visible: visible, value: $password)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.forgotPassword.toggle()
                        }, label: {
                            Text("Passwort vergessen?")
                                .fontWeight(.bold)
                                .foregroundColor(Color(.white))
                        })
                        
                        Spacer()
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                    
                    LoginButton(email: $email, password: $password, error: $error, alert: $alert, alertEmailVerification: $alertEmailVerification, viewState: $next)
                }
                .background(Color.black.opacity(0.5))
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
            
            VStack {
                
                ZStack {
                    
                    Text("Anmeldung")
                        .padding(.top, 10)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                        .hCenter()
                        .zIndex(1)
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        ).colorInvert()
                }
                
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }
                .background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()

            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
            
            if self.alertEmailVerification {
                ErrorSendEmailView(back: self.$alertEmailVerification, email: self.$email)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
