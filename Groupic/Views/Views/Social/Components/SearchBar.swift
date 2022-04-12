//
//  SearchBar.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.03.22.
//

import SwiftUI

struct SearchBar: View {
    @Binding var value: String
    @State var isSearching = false
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 20))

            TextField("", text: $value)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .autocapitalization(.none)
                .onTapGesture {
                    isSearching = true
                }
                .overlay(
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            value = ""
                        }, label: {
                            Image(systemName: "xmark.circle.fill")
                        })
                    }
                    .padding(.horizontal, 32)
                    .foregroundColor(.gray)
                )
        }
        .padding(.horizontal)
    }
}

