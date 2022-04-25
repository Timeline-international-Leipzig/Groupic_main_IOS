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
                            }
                            
                            Spacer()
                            
                            HStack {
                                Rectangle().frame(width: getRectView().width, height: 100)
                            }.background(Color(.black))
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                                )
                            
                        }.zIndex(1)
                        
                        VStack {
                            /*Text("Willkommen!")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)*/
                            
                            Group {
                                TextEditField(selectedIndex: 1, header: "Name", image: "mail", textField: "", value: $name)
                                
                                TextEditField(selectedIndex: 2, header: "Nutzername", image: "mail", textField: "", value: $username)
                                
                                VStack (alignment: .leading) {
                                    HStack {
                                        
                                        VStack {
                                        
                                            CheckBoxView(checked: $checked).background(Color(.white))
                                        
                                        CheckBoxView(checked: $checkedSecond).background(Color(.white))
                                            
                                        }
                                        
                                        VStack {
                                            
                                            HStack {
                                        
                                        Text("Ich bin mit der")
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            self.nextAGB.toggle()
                                        }, label: {
                                            Text("AGB")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .bold))
                                        })
                                        
                                        Text(" einverstanden")
                                            .foregroundColor(.white)
                                        
                                            }
                                            
                                            HStack {
                                        
                                        Text("Ich bin mit dem")
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            self.nextDatenschutz.toggle()
                                        }, label: {
                                            Text("Datenschutz")
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .bold))
                                        })
                                            
                                        
                                        Text(" einverstanden")
                                            .foregroundColor(.white)
                                        }
                                        }
                                    }
                                }
                                   
                                
                                RegisterButtonNoPictures(name: $name, username: $username, email: $email, password: $password, error: $error, alert: $alert, next: $nextView, checked: $checked, checkedSecond: $checkedSecond, viewState: $viewState)
                            }
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

