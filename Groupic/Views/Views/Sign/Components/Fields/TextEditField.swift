//
//  LoginField.swift
//  Groupic
//
//  Created by Anatolij Travkin on 11.04.22.
//

//
//  LoginRegisterField.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI
import Firebase

struct TextEditField: View {
    @State var errorCheckBool = false
    @State var selectedIndex: Int
    
    var header: String
    var image: String
    var textField: String

    var allowed = CharacterSet(charactersIn: "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ._-+$!~&=#[]@")
    var allowedBeta = CharacterSet(charactersIn: "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ")
    var allowedAlpha: CharacterSet = .alphanumerics
    var limit = 50
    
    @Binding var value: String
    
    var body: some View {
        VStack {
            Text(header)
                .fontWeight(.bold)
                .foregroundColor(Color("AccentColor"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            VStack {
                HStack {
                    Image(systemName: image).padding(.horizontal, 10)

                    TextField(textField, text: $value)
                        .autocapitalization(.none)
                        .padding(.horizontal, 10)
                        .font(.system(size: 15, weight: .bold))
                        .onChange(of: value) {_ in
                            if selectedIndex == 0 {
                                value = String(value.prefix(limit).unicodeScalars.filter(allowed.contains))
                                
                                if isValidEmail(value) == false {
                                    self.errorCheckBool = true
                                }
                                
                                else {
                                    self.errorCheckBool = false
                                }
                            }
                            
                            if selectedIndex == 1 {
                                value = String(value.prefix(limit).unicodeScalars.filter(allowedBeta.contains))
                                
                                if value.count > 20 {
                                    self.errorCheckBool = true
                                }
                                
                                else {
                                    self.errorCheckBool = false
                                }
                            }
                            
                            if selectedIndex == 2 {
                                value = String(value.prefix(limit).unicodeScalars.filter(allowedAlpha.contains))
                                
                                if isValidUsername(value) == false {
                                    self.errorCheckBool = true
                                }
                                
                                else {
                                    self.errorCheckBool = false
                                }
                            }
                            
                            if selectedIndex == 2 {
                                value = String(value.prefix(limit).unicodeScalars.filter(allowed.contains))
                            }
                        }
                }
                
                Divider()
                    .background(Color("AccentColor"))
                    .padding(.top, 7.5)
            }
            .padding(.top, 7.5)
            
            switch selectedIndex {
                case 0:
                Text(
                    self.errorCheckBool ? "Die Form deiner E-Mail ist nicht valide!" : ""
                )
                .foregroundColor(.red)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
                    
                case 1:
                    Text(
                        self.errorCheckBool ? "Der Name darf nicht länger als 20 Zeichen sein!" : ""
                    )
                    .foregroundColor(.red)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                case 2:
                    Text(
                        self.errorCheckBool ? "Der Nutzername muss zwischen 4 und 10 Zeichen sein!" : ""
                    )
                    .foregroundColor(.red)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                case 3:
                    Text("")
                    
                
                default:
                    Text("Remaining tabs")
                }
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidUsername(_ username: String) -> Bool {
        let emailRegEx = "\\w{7,18}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: username)
    }
}

