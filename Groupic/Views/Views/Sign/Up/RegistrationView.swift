//
//  RegistrationView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 30/09/2021.
//

import SwiftUI
import Firebase

struct RegistrationView: View {
    @State var color = Color.black
    
    @State var email = ""
    @State var password = ""
    @State var repassword = ""
    @State var error = ""
    
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var next = false
    
    @Binding var back: Bool
    
    var body: some View {
        ZStack {
            ZStack (alignment: .topLeading) {
                GeometryReader {_ in
                    NavigationLink(destination: PersonInfoViewNoPictures(next: $next, viewState: $back, email: $email, password: $password, repassword: $repassword), isActive: self.$next, label: {
                        EmptyView()
                    })
                    
                    VStack {
                    
                        ZStack {
                            
                            Text("Registrierung")
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
                                )
                                .colorInvert()
                        }
                        
                        Spacer()
                        
                        HStack {
                            Rectangle().frame(width: getRectView().width, height: 100)
                        }.background(Color(.black))
                            .mask(
                                LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                            )
                            .colorInvert()
                        
                    }.zIndex(1)
                    
                    VStack {
                        /*Image("glogo-nb")
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal, 25)
                            .padding(.top, 25)
                            .frame(width: 80, height: 80)*/
                        
                        TextEditField(selectedIndex: 0, header: "E-Mail", image: "mail", textField: "", value: $email)
                        
                        SecureTextEditField(selectedIndex: 1, password: "", header: "Passwort", image: "lock", textField: "", visible: visible, value: $password)
                        
                        SecureTextEditField(selectedIndex: 0, password: password, header: "Wiederhole dein Passwort", image: "lock", textField: "", visible: visible, value: $repassword)
                        
                        NextButton(email: $email, password: $password, repassword: $repassword, error: $error, alert: $alert, next: $next, viewState: $back)
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
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
}
