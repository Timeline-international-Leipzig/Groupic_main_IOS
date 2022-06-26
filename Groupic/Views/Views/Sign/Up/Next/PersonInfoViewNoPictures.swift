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
                                    .font(.custom("Inter-Regular", size: 22))
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
                            }.background(Color(.black))
                                .mask(
                                    LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                                ).colorInvert()
                            
                        }.zIndex(1)
                        
                        VStack {
                            
                            Group {
                                TextEditField(selectedIndex: 1, header: "Name", image: "mail", textField: "", value: $name)
                                
                                TextEditField(selectedIndex: 2, header: "Nutzername", image: "mail", textField: "", value: $username)
                                
                                VStack (alignment: .leading) {
                                    HStack {
                                        
                                        VStack {
                                        
                                            CheckBoxView(checked: $checked)
                                        
                                            CheckBoxView(checked: $checkedSecond)
                                                .padding(.top, 30)
                                            
                                        }
                                        
                                        VStack(alignment: .leading) {
                                            
                                            HStack {
                                        
                                        Text("Ich bin mit den")
                                                    .font(.custom("Inter-Regular", size: 16))
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            self.nextAGB.toggle()
                                        }, label: {
                                            Text("AGB")
                                                .font(.custom("Inter-ExtraBold", size: 18))
                                                .foregroundColor(.white)
                                        })
                                        
                                        Text(" einverstanden")
                                                    .font(.custom("Inter-Regular", size: 16))
                                            .foregroundColor(.white)
                                        
                                            }
                                            
                                            HStack {
                                        
                                        Text("Ich bin mit dem")
                                                    .font(.custom("Inter-Regular", size: 16))
                                            .foregroundColor(.white)
                                        
                                        Button(action: {
                                            self.nextDatenschutz.toggle()
                                        }, label: {
                                            Text("Datenschutz")
                                                .font(.custom("Inter-ExtraBold", size: 18))
                                                .foregroundColor(.white)
                                        })
                                            }.padding(.top, 20)
                                            
                                            Text("einverstanden.")
                                                .font(.custom("Inter-Regular", size: 16))
                                                .foregroundColor(.white)
                                            
                                        }.padding(.top, 20)
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

