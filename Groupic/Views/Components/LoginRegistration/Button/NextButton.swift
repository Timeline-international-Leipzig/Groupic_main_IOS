//
//  NextButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 22/10/2021.
//

import SwiftUI

struct NextButton: View {
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    @Binding var error: String
    @Binding var alert: Bool
    @Binding var next: Bool
    @Binding var viewState: Bool
    
    var body: some View {
        VStack {
                Button(action: {
                    self.next.toggle()
                }, label: {
                    Text("Weiter")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                })
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .padding(.bottom, 25)
                .padding(.horizontal, 10)
                
                HStack {
                    Text("Bereits Nutzer?")
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    Button(action: {
                        self.viewState.toggle()
                    }, label: {
                        Text("Einloggen")
                            .fontWeight(.bold)
                            .foregroundColor(Color("AccentColor"))
                    })
                }
                .padding(.bottom, 20)
        }
        .padding(.top, 45)
    }

    //Next
    func nextview() {
        if email != "" {
            if password == self.repassword {
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
}
