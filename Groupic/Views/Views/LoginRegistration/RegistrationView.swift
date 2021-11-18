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
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var error = ""
    @State var errortitle = ""
    @State var closetitle = ""
    @State var next = false

    @Binding var viewState: Bool
    
    var body: some View {
        ZStack {
            ZStack (alignment: .topLeading) {
                GeometryReader {_ in
                    
                    NavigationLink(destination: PersonInfoView(next: $next, viewState: $viewState, email: $email, password: $password, repassword: $repassword), isActive: self.$next, label: {
                        EmptyView()
                    })
                    
                    VStack {
                        Image("glogo-nb")
                            .resizable()
                            .scaledToFill()
                            .padding(.horizontal, 25)
                            .padding(.top, 25)
                            .frame(width: 80, height: 80)

                        LoginRegisterField(header: "E-Mail", image: "mail", textField: "groupic@mail.com", field: true, visible: visible, color: color, value: $email)
                        
                        LoginRegisterField(header: "Passwort", image: "lock", textField: "********", visible: visible, color: color, value: $password)
                        
                        LoginRegisterField(header: "Wiederhole dein Passwort", image: "lock", textField: "********", visible: visible, color: color, value: $repassword)
                        
                        NextButton(email: $email, password: $password, repassword: $repassword, error: $error, alert: $alert, next: $next, viewState: $viewState)
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
                ErrorView(alert: self.$alert, error: self.$error, errortitle: $errortitle, closetitle: $closetitle)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
}
