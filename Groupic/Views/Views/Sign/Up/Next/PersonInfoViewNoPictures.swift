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
    @State var checked = false
    @State var checkedSecond = false
    
    @Binding var next: Bool
    @State var nextView = false
    @Binding var viewState: Bool
    
    @State var nextAGB = false
    @State var nextDatenschutz = false
    
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    
    var body: some View {
        NavigationLink(destination: VerificationView(), isActive: self.$nextView, label: {
            EmptyView()
        })
        
        NavigationLink(destination: AGBView(back: $nextAGB), isActive: self.$nextAGB, label: {
            EmptyView()
        })
        
        NavigationLink(destination: DatenschutzView(back: $nextDatenschutz), isActive: self.$nextDatenschutz, label: {
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
                                
                                VStack {
                                    HStack {
                                        CheckBoxView(checked: $checked)
                                        
                                        Text("Ich bin mit der")
                                        
                                        Button(action: {
                                            self.nextAGB.toggle()
                                        }, label: {
                                            Text("AGB")
                                                .foregroundColor(Color("AccentColor"))
                                        })
                                        
                                        Text(" einverstanden")
                                        
                                        Spacer()
                                    }
                                    .padding(.horizontal, 4)
                                    
                                    HStack {
                                        CheckBoxView(checked: $checkedSecond)
                                        
                                        Text("Ich bin mit dem")
                                        
                                        Button(action: {
                                            self.nextDatenschutz.toggle()
                                        }, label: {
                                            Text("Datenschutz")
                                                .foregroundColor(Color("AccentColor"))
                                        })
                                        
                                        Text(" einverstanden")
                                    }
                                    .padding(.top, 2)
                                }
                                .padding(.horizontal, 10)
                                .padding(.top, 5)
                                
                                RegisterButtonNoPictures(name: $name, username: $username, email: $email, password: $password, error: $error, alert: $alert, next: $nextView, checked: $checked, checkedSecond: $checkedSecond, viewState: $viewState)
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

