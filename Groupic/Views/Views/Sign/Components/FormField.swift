//
//  FormField.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI

struct FormField: View {
    var icon: String
    var placeholder: String
    var visible = false
    
    @Binding var value: String
    
    var body: some View {
        Group {
            HStack {
                Image(systemName: icon).padding()
                
                Group {
                    if visible {
                        SecureField(placeholder, text: $value)
                    }
                    else {
                        TextField(placeholder, text: $value)
                    }
                }
                .autocapitalization(.none)
                .padding()
                .padding(.horizontal, 10)
                .font(.system(size: 15, weight: .bold))
            }
        }
    }
}


