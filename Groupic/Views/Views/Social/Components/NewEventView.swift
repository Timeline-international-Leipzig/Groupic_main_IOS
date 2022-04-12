//
//  NewEventView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 26.01.22.
//

import SwiftUI

struct NewEventView: View {
    
    var Cover: String
    var Date: String
    var Titel: String
    
    var body: some View {
        
        ZStack{
            
            HStack{
                VStack{
                    //Kreis
                    Image(systemName: "circle")
                        .foregroundColor(.gray)
                        .font(.system(size: 10))
                    
                    Rectangle()
                        .fill(.gray)
                        .frame(width: 1, height: 240)
                        .padding(.horizontal)
                    
                }
                
                VStack{
                    Text(Date)
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .light, design: .default))
                        .hLeading()
                        
                    Spacer()
                    
                    Text(Titel)
                        .font(.system(size: 22, weight: .medium, design: .default))
                        .padding(.vertical)
                        .hLeading()
                }
                
            }.hLeading()
            
            Button(
                action: {},
                label: {
                    Image(Cover)
                        .resizable()
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .clipped()
                }
            ).offset(y:-10)
            
        }.frame(width: getRectView().width, height: 260, alignment: .center)
            .padding(.vertical, 3)
    }
}

