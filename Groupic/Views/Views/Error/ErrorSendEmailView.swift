//
//  ErrorSendEmailView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27.04.22.
//

import SwiftUI
import Firebase

struct ErrorSendEmailView: View {
    @State var color = Color.black.opacity(0.7)
    
    @Binding var back: Bool
    
    @State var error = "Verifiziere bitte erst deine E-Mail"
    @State var password = ""
    @Binding var email: String
    
    @State var closetitle = "Schließen"
    
    @State var visible = false
    @State var nextView = false
    @State var alert = false
    
    var body: some View {
        NavigationLink(destination: VerificationView(), isActive: self.$nextView, label: {
            EmptyView()
        })
        
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            Auth.auth().currentUser?.sendEmailVerification { error in
                            }
                        }, label: {
                            Text("E-Mail erneut senden")
                                .fontWeight(.bold)
                                .foregroundColor(Color("AccentColor"))
                        })
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 5)
                                        
                    Button(action: {
                        self.back.toggle()
                    }, label: {
                        Text("Schließen")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                }
                .padding(.all, 25)
                .frame(width: UIScreen.main.bounds.width - 90)
                .background(Color.white.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
}


    
