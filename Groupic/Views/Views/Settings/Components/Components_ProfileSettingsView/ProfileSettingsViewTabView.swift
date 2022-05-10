//
//  ProfileSettingsViewTabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.04.22.
//

import SwiftUI

struct ProfileSettingsViewTabView: View {
    @Binding var back: Bool
    
    var body: some View {
        ZStack {
            
            VStack {
                
                ZStack {
                    
                    HStack {
                        
                        Button(action: {
                            self.back.toggle()
                        },
                        label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                        })
                        .padding()
                        
                        Spacer()
                        
                    }.zIndex(1)
                    
                    Text("Profil bearbeiten")
                        .padding(.top, 10)
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.white)
                        .hCenter()
                        .zIndex(1)
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        )
                }
                
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    )
            }.zIndex(1)
        }.background(Color("background"))
        .ignoresSafeArea()
    }
}


