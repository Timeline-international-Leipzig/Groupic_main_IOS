//
//  LoginRegisterField.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI

struct LoginRegisterField: View {
    var header: String
    var image: String
    var textField: String
    var field = false
    
    @State var visible = false
    @State var color = Color.black
    
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
                    
                    if field {
                        TextField(textField, text: $value)
                            .autocapitalization(.none)
                            .padding(.horizontal, 10)
                            .font(.system(size: 15, weight: .bold))
                    }
                    else {
                        HStack() {
                            VStack {
                                if self.visible {
                                    TextField(textField, text: $value)
                                        .autocapitalization(.none)
                                        .padding(.horizontal, 10)
                                        .font(.system(size: 15, weight: .bold))
                                }
                                else {
                                    SecureField(textField, text: $value)
                                        .autocapitalization(.none)
                                        .padding(.horizontal, 10)
                                        .font(.system(size: 15, weight: .bold))
                                }
                            }
                        
                            Button(action: {
                                self.visible.toggle()
                            }, label: {
                                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                    .foregroundColor(self.color)
                            })
                            .padding(.horizontal, 10)
                        }
                    }
                }
                
                Divider()
                    .background(Color("AccentColor"))
                    .padding(.top, 7.5)
            }
            .padding(.top, 7.5)
        }
        .padding(.horizontal, 10)
        .padding(.top, 20)
    }
}
