//
//  EditTextField.swift
//  Groupic
//
//  Created by Anatolij Travkin on 31.03.22.
//

import SwiftUI

struct EditTextField: View {
    var textField: String
    
    @Binding var value: String
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TextField(textField, text: $value)
                        .autocapitalization(.none)
                        .padding(.horizontal, 10)
                        .font(.system(size: 15, weight: .bold))
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


