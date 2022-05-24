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
        
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(.leading, 15)
                
                TextField("", text: $value)
                    .padding(.all, 5)
                    .accentColor(.white)
                    .background(Color("mainColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding()
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
                                    .foregroundColor(.white)
                            })
                        }
                            .padding(.horizontal, 15)
                            .foregroundColor(.gray)
                    )
            }
            .padding(.horizontal)
            
            Divider()
                .background(Color.white)
                .padding(.horizontal, 18)
                .offset(y: -12)
        }
    }
}

