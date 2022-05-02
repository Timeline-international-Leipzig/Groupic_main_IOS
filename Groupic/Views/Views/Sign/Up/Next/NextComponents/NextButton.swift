//
//  NextButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 22/10/2021.
//

import SwiftUI
import Firebase

struct NextButton: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    @Binding var error: String
    @Binding var alert: Bool
    @Binding var next: Bool
    @Binding var viewState: Bool
    
    var userCollection = Firestore.firestore().collection("users")
    @State var userHasAccount = false
    
    var body: some View {
        VStack {
            Button(action: {
                checkIfEmailOfAccountExists { result in
                    if (result == true) {
                        self.userHasAccount = true
                        self.error = "Diese E-Mail existiert bereits! \n Wähle bitte eine neue E-Mail"
                        self.alert.toggle()
                    }
                    else {
                        self.userHasAccount = false
                        self.nextView()
                    }
                }
            }, label: {
                Text("Weiter")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .padding(.vertical)
                    .frame(width: UIScreen.main.bounds.width - 50)
            })
            .background(Color("AccentColor"))
            .cornerRadius(10)
            .padding(.bottom, 25)
            .padding(.horizontal, 10)
            
            VStack {
                Text("account bereits vorhanden?")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Button(action: {
                    self.viewState.toggle()
                }, label: {
                    Text("hier anmelden")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                })
            }
            .padding(.bottom, 20)
        }
        .padding(.top, 45)
    }

    //Next View & Error Check
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
    
    func nextView() {
        if email != "" {
            if password == repassword {
                self.next.toggle()
            }
            else {
                self.error = "Passwörter stimmen nicht überein"
                self.alert.toggle()
            }
        }
        else {
            self.error = "Es wurde nicht alles ausgefüllt"
            self.alert.toggle()
        }
    }
    
    func clear() {
        self.email = ""
        self.password = ""
    }
}
