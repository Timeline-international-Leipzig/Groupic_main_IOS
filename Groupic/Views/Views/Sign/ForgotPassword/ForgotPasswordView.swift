//
//  ForgotPasswordView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 16.04.22.
//

import SwiftUI
import Firebase

struct ForgotPasswrdView: View {
    @EnvironmentObject var session: SessionStore
    @Binding var forgotPassword: Bool
    
    @State var alert = false
    @State var error = "Die E-Mail wurde versendet!"
    @State var email = ""
    
    var userCollection = Firestore.firestore().collection("users")
    
    @State var login = false
    
    var body: some View {
        NavigationLink(destination: CustomTabView(), isActive: self.$login, label: {
            EmptyView()
        })
        
            ZStack {
                ZStack (alignment: .topLeading) {
                    GeometryReader {_ in
                        VStack {
                            Text("Ändere dein Passwort")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)
                            
               
                            TextEditField(selectedIndex: 3, header: "E-Mail", image: "mail", textField: "Deine E-Mail zum ändern des Passworts", value: $email)
                            
                            Group {
                                Button(action: {
                                    checkIfEmailOfAccountExists { result in
                                        if (result == true) {
                                            self.error = "Die E-Mail wurde versendet"
                                            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                                                self.error = "Es ist ein Fehler aufgetreten"
                                                self.alert.toggle()
                                            }
                                            
                                            self.alert.toggle()
                                        }
                                        else {
                                            self.error = "Diese E-Mail existiert nicht"
                                            self.alert.toggle()
                                        }
                                    }
                                }, label: {
                                    Text("Passwort ändern")
                                        .foregroundColor(.white)
                                        .padding(.vertical)
                                        .frame(width: UIScreen.main.bounds.width - 50)
                                })
                                .background(Color("AccentColor"))
                                .cornerRadius(10)
                                .padding(.horizontal, 10)
                                .padding(.bottom)
                            }
                            
                            HStack {
                                Button(action: {
                                    self.forgotPassword.toggle()
                                }, label: {
                                    Text("Zurück")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("AccentColor"))
                                })
                                
                                Spacer()
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
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
    
    func checkIfEmailOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("email", isEqualTo: self.email).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is already a user with this email")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
}





