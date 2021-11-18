//
//  PersonInfoView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI
import Firebase

struct PersonInfoView: View {
    
    @State var color = Color.black
    @State var name = ""
    @State var username = ""
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    @State var error = ""
    @State var errortitle = ""
    @State var closetitle = ""
    
    @Binding var next: Bool
    @Binding var viewState: Bool
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    
    var body: some View {
            ZStack {
                ZStack (alignment: .topLeading) {
                    GeometryReader {_ in
                        VStack {
                            Text("Willkommen!")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)
                            
                            LoginRegisterField(header: "Name", image: "mail", textField: "Dein persönlicher Name", field: true, visible: visible, color: color, value: $name)
                            
                            LoginRegisterField(header: "Nutzername", image: "mail", textField: "Dein gewünschter Nutzername", field: true, visible: visible, color: color, value: $username)
                            
                            RegisterButton(email: $email, password: $password, repassword: $repassword, error: $error, alert: $alert, viewState: $viewState)
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
