//
//  ProfileSettingsViewTabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.04.22.
//

import SwiftUI

struct ProfileSettingsViewTabView: View {
    
    @Binding var back: Bool
    @State var next = false
    
    var body: some View {
        NavigationLink(destination: SettingsView(), isActive: $next, label: {
            EmptyView()
        })
        
        ZStack {
            VStack {
                
                ZStack {
                    HStack {
                        Spacer()
                        
                        Text("Profil bearbeiten")
                            .font(.custom("Inter-Regular", size: 22))
                            .foregroundColor(.white)
                        
                        Spacer()
                    }.padding(.top, 50)
                    
                    HStack {
                        Button(action: {
                            self.next.toggle()
                        },
                               label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        }).padding(.top, 50)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                }
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    ).colorInvert()
                
                Spacer()
            }
        }
    }
}


