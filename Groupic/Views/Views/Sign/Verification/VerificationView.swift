//
//  VerificationView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.04.22.
//

import SwiftUI
import Firebase

struct VerificationView: View {
    @EnvironmentObject var session: SessionStore
    
    @State var alert = false
    @State var error = "Die E-Mail wurde noch nicht verfiziert!"
    
    @State var login = false
    
    var body: some View {
        NavigationLink(destination: CustomTabView(), isActive: self.$login, label: {
            EmptyView()
        })
        
            ZStack {
                ZStack (alignment: .topLeading) {
                    GeometryReader {_ in
                        
                        VStack {
                        
                            ZStack {
                                
                                Text("Verifizierung")
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
                            Text("Fast geschafft!")
                                .foregroundColor(.white)
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)
                            
               
                            Text("Verifiziere bitte deine E-Mail!")
                                .foregroundColor(.white)
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
                                Spacer()
                                
                                Button(action: {
                                    Auth.auth().currentUser?.sendEmailVerification { error in
                                    }
                                }, label: {
                                    Text("E-Mail erneut senden")
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                })
                            }
                            .padding()
                            .padding(.bottom, 20)
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



