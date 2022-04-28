//
//  VerificationReauthetificationView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27.04.22.
//

import SwiftUI
import Firebase

struct VerificationReauthetificationView: View {
    @EnvironmentObject var session: SessionStore
    
    @State var alert = false
    @State var error = "Die E-Mail wurde noch nicht verfiziert!"
    
    @State var login = false
    @State var email = false
    
    var body: some View {
        NavigationLink(destination: CustomTabView(), isActive: self.$login, label: {
            EmptyView()
        })
        
            ZStack {
                ZStack (alignment: .topLeading) {
                    GeometryReader {_ in
                        VStack {
                            Text("Deine Identität bestätigen")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)
                            
               
                            Text("Verifiziere bitte deine neue E-Mail! Sonst müssen wir dich leider ausloggen")
                                .padding()
                                .padding(.horizontal, 25)
                            
                            Group {
                                Button(action: {
                                    Auth.auth().currentUser?.reload(completion: { (err) in
                                         if err == nil{
                                             if session.session != nil && Auth.auth().currentUser?.isEmailVerified == true {
                                                 self.login.toggle()
                                             } else {
                                                 self.alert.toggle()
                                             }
                                         }
                                     })
                                    
                                }, label: {
                                    Text("Die E-Mail wurde verifiziert!")
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 50)
                                })
                                .background(Color("AccentColor"))
                                .cornerRadius(10)
                                .padding(.horizontal, 10)
                            }
                            
                            HStack {
                                Button(action: {
                                    self.email.toggle()
                                }, label: {
                                    Text("Neue E-Mail wählen")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("AccentColor"))
                                })
                                
                                Spacer()
                                
                                Button(action: {
                                    Auth.auth().currentUser?.reload(completion: { (err) in
                                        Auth.auth().currentUser?.sendEmailVerification { error in
                                        }
                                    })
                                }, label: {
                                    Text("E-Mail erneut senden")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("AccentColor"))
                                })
                            }
                            .padding()
                            .padding(.bottom, 20)
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
                }
                
                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error)
                }
                
                if self.email {
                    ReEmailView(back: self.$email)
                }
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}





