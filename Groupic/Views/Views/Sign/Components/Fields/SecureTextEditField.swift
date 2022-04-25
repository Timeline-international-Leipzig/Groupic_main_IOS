//
//  LoginRegisterField.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI

struct SecureTextEditField: View {
    @State var errorCheckBool = false
    @State var selectedIndex: Int
    
    var password: String
    var header: String
    var image: String
    var textField: String
    
    var allowed = CharacterSet(charactersIn: "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ._-+$!~&=#[]@")
    var limit = 20
    
    @State var visible = false
    
    @Binding var value: String
    
    var body: some View {
        VStack {
            Text(header)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .center)
            
            VStack {
                HStack {
                    Image(systemName: image)
                        .foregroundColor(.white)
                        .padding(.horizontal, 10)
                
                    HStack() {
                        VStack {
                            if self.visible {
                                TextField(textField, text: $value)
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 10)
                                    .font(.system(size: 15, weight: .bold))
                                    .onChange(of: value) { _ in
                                        value = String(value.prefix(limit).unicodeScalars.filter(allowed.contains))
                                        
                                        if self.selectedIndex == 1 {
                                            if isValidPassword(value) == false {
                                                self.selectedIndex = 1
                                                self.errorCheckBool = true
                                            }
                                            
                                            else {
                                                self.errorCheckBool = false
                                            }
                                        }
                                        
                                        if selectedIndex == 0 {
                                            if value != password {
                                                self.errorCheckBool = true
                                            }
                                            
                                            else {
                                                self.errorCheckBool = false
                                            }
                                        }
                                    }
                            }
                            else {
                                SecureField(textField, text: $value)
                                    .foregroundColor(.white)
                                    .accentColor(.white)
                                    .autocapitalization(.none)
                                    .padding(.horizontal, 10)
                                    .font(.system(size: 15, weight: .bold))
                                    .onChange(of: value) { _ in
                                        value = String(value.prefix(limit).unicodeScalars.filter(allowed.contains))
                                        
                                        if self.selectedIndex == 1 {
                                            if isValidPassword(value) == false {
                                                self.selectedIndex = 1
                                                self.errorCheckBool = true
                                            }
                                            
                                            else {
                                                self.errorCheckBool = false
                                            }
                                        }
                                        
                                        if selectedIndex == 0 {
                                            if value != password {
                                                self.errorCheckBool = true
                                            }
                                            
                                            else {
                                                self.errorCheckBool = false
                                            }
                                        }
                                    }
                            }
                        }
                    
                        Button(action: {
                            self.visible.toggle()
                        }, label: {
                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white)
                        })
                        .padding(.horizontal, 10)
                    }
                }
                
                Divider()
                    .background(Color(.white))
                    .padding(.top, 7.5)
            }
            .padding(.top, 7.5)
            
            switch selectedIndex {
                case 0:
                Text(
                    self.errorCheckBool ? "Passwörter stimmen nicht überein!" : ""
                )
                .foregroundColor(.red)
                .fontWeight(.light)
                .frame(maxWidth: .infinity, alignment: .leading)
                    
                case 1:
                    Text(
                        self.errorCheckBool ? "Das Passwort muss mindestens 8 Zeichen und mind. einen Großbuchstaben / Kleinbuchstaben / Sonderzeichen besitzen!" : ""
                    )
                    .foregroundColor(.red)
                    .fontWeight(.light)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                case 2:
                    Text("")
                
                default:
                    Text("default")
                }
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let RegEx = "(?=^.{8,}$)(?=.*[!@#$%^&*.]+)(?=.*[A-Z])(?=.*[a-z]).*$"

        let Pred = NSPredicate(format:"SELF MATCHES %@", RegEx)
        return Pred.evaluate(with: password)
    }
}
