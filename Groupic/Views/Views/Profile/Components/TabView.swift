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
            HStack(spacing: 15) {
                Spacer()
                
                Text(user!.name)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(alignment: .center)
                
                Spacer()
            }
            .padding()
            .background(Color("AccentColor"))
            
            HStack() {
                Spacer()
                
                Button(action: {
                    self.next.toggle()
                }, label: {
                    Image(systemName: "line.horizontal.3")
                        .foregroundColor(.white)
                })
            }
            .padding()
        }
    }
}

