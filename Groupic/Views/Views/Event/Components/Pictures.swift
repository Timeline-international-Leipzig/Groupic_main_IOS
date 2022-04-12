//
//  Pictures.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.01.22.
//

import SwiftUI

struct Pictures: View {
    var body: some View {
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(),spacing: 2), count: 3), spacing: 2, content: {
            ForEach(1...10,id: \.self){index in
                
                GeometryReader{ proxy in
                    
                    let width = proxy.frame(in: .global).width
                    
                    ImageView(index: index, width: width)
                    
                }
                .frame(height: 120)
            }
        })
    }
}
        
struct ImageView: View {
            
    var index: Int
    var width: CGFloat
            
    var body: some View{
                
        VStack{
            
            let imageName = index > 10 ? index - (10 * (index / 10)) == 0 ? 10: index - (10 * (index / 10)) : index
            
            Button(action: {}, label:{
                    Image("Berg\(imageName)")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width, height: 120)
                    .cornerRadius(0)
            })
        }
                
    }
}
