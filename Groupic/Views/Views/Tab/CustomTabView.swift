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
                
                VStack {
                    
                    Spacer()
                    
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
                                        .foregroundColor(selectedIndex == num ? Color(.white) : .init(white: 0.8))
                                }
                                
                                Spacer()
                            })
                        }
                    }.padding(.bottom, 20)
                        .padding(.top, 10)
                }.zIndex(1)
                
                VStack {
                    
                    Spacer()
                    
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                        ).colorInvert()
                }
            }
        }.ignoresSafeArea()
    }
}


