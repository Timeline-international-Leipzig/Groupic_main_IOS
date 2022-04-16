//
//  PersonInfoViewTest.swift
//  Groupic
//
//  Created by Anatolij Travkin on 06.04.22.
//

import SwiftUI
import Firebase

struct PersonInfoViewNoPictures: View {
    @State var name = ""
    @State var username = ""
    
    @State var error = ""
    @State var errortitle = ""
    
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    
    @Binding var next: Bool
    @State var nextView = false
    @Binding var viewState: Bool
    
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    
    var body: some View {
        NavigationLink(destination: VerificationView(), isActive: self.$nextView, label: {
            EmptyView()
        })
        
            ZStack {
                ZStack (alignment: .topLeading) {
                    GeometryReader {_ in
                        VStack {
                            Text("Willkommen!")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)
                            
                            Group {
                                TextEditField(selectedIndex: 1, header: "Name", image: "mail", textField: "Dein persönlicher Name", value: $name)
                                
                                TextEditField(selectedIndex: 2, header: "Nutzername", image: "mail", textField: "Dein gewünschter Nutzername", value: $username)
                                
                                RegisterButtonNoPictures(name: $name, username: $username, email: $email, password: $password, error: $error, alert: $alert, next: $nextView, viewState: $viewState)
                            }
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
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}

