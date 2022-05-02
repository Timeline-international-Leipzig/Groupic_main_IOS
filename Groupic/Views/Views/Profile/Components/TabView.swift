//
//  TabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.01.22.
//

import SwiftUI

struct TabView: View {
    @State var next = false
    var user: UserModel?
    
    var body: some View {
        NavigationLink(destination: SettingsView(next: $next), isActive: self.$next, label: {
            EmptyView()
        })
        
        ZStack {
            
            VStack {
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    )
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                HStack(spacing: 15) {
                    Spacer()
                    
                    Button(action: {},
                           label: {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        
                    }).padding(.horizontal, 20)
                    
                    Text(user!.name)
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                    
                    Button(action: {
                        self.next.toggle()
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }).padding(.horizontal, 20)
                    
                    Spacer()
                }
                .padding(.top, 50)
                .padding(.bottom, 10)
                
                Spacer()
            }.zIndex(1)
        }.ignoresSafeArea()
    }
}

