//
//  CustomTabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 27.12.21.
//

import SwiftUI
import Firebase

struct CustomTabView: View {
    @EnvironmentObject var session: SessionStore
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
        UINavigationBar.appearance().barTintColor = .systemBackground
    }
    
    @State var selectedIndex = 0
    @State var show = false
    @State var shouldShowModel = false
    
    let tabBarImageNames = ["person.2.fill","plus.square.fill","camera.on.rectangle.fill"]
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModel, content: {
                        
                        AddEventView(user: self.session.session!, shouldShowModel: $shouldShowModel)
                        
                    })
                
                switch selectedIndex {
                case 0:
                    SocialView()
                    
                case 1:
                    AddEventView(user: self.session.session!, shouldShowModel: $shouldShowModel)
                    
                default:
                    ProfileView()
                }
            }
            
            Divider()
                .padding(.bottom, 8)
            
            HStack {
                ForEach(0..<3) { num in
                    Button(action: {
                        if num == 1 {
                            shouldShowModel.toggle()
                            return
                        }
                        
                        selectedIndex = num
                        
                    }, label: {
                        Spacer()
                        
                        if num == 1 {
                            Image("plusButton")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .clipped()
                        } else {
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        }
                        
                        Spacer()
                    })
                }
            }
        }
    }
}


