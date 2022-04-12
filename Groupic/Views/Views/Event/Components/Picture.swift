//
//  Picture.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.01.22.
//


import SwiftUI

struct Picture: View {
    
    var Pic: String
    
    var body: some View {
        Image(Pic)
            .resizable()
            .frame(width: 120, height: 120, alignment: .center)
            .clipped()
    }
}
