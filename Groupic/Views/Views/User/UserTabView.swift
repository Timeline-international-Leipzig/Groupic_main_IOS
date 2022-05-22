//
//  UserTabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.03.22.
//

import SwiftUI

struct UserTabView: View {
    
    var user: UserModel
    
    @Binding var next: Bool
    
    var body: some View {
        ZStack {
            
            VStack {
                
                ZStack {
                    
                    HStack {
                        
                        Button(action: {
                            self.next.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        
                        Spacer()
                        
                    }.zIndex(1)
                    
                    Text(user.userName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                        .zIndex(1)
                        .padding(.top, 10)
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        ).colorInvert()
                }
                
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
            }
        }.ignoresSafeArea()
    }
}

