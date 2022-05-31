//
//  MidTabBarView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 24.01.22.
//

import SwiftUI
import Firebase

struct MidTabBarView: View {    
    @State var selectedIndex = 0
    let tabBarImageName = ["Highlights","Ereignisse","Anstehend","Kontakte"]
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                ForEach(0..<4) {
                    num in
                    
                    Button(action: {
                        withAnimation {
                            selectedIndex = num
                        }
                    }, label: {
                        if num == selectedIndex {
                            
                            Spacer()
                            
                            Text(tabBarImageName[num])
                                .foregroundColor(Color(.white))
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            
                            Spacer()
                            
                        }
                        
                        else {
                            
                            Spacer()
                            
                            Text(tabBarImageName[num])
                                .foregroundColor(.white)
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                            
                            Spacer()
                            
                        }
                    }
                    )
                }
            }.background(
                ZStack {
                    HStack {
                        Rectangle()
                            .fill(Color(.white))
                            .frame(width: getRectView().width, height: 3)
                    }.padding(.top, 40)
                    
                    HStack {
                        if selectedIndex == 3 { Spacer() }
                        if selectedIndex == 1 { Spacer() }
                        if selectedIndex == 2 {
                            Spacer()
                            Spacer()
                        }
                        Rectangle()
                            .fill(Color("themeColor2"))
                            .frame(width: UIScreen.main.bounds.width * 0.25, height: 3, alignment: .leading)
                        if selectedIndex == 0 { Spacer() }
                        if selectedIndex == 1 {
                            Spacer()
                            Spacer()
                        }
                        if selectedIndex == 2 { Spacer() }
                    }.padding(.top, 40)
                }
            )
            
            ZStack{
                switch selectedIndex {
                case 0:
                    HighlightPostView()
                        .padding(.top)
                    
                case 1:
                    UserPostView()
                        .padding(.top)
                    
                case 2:
                    FutureUserPostView()
                        .padding(.top)
                    
                case 3:
                    ContactsView()
                        .padding(.top)
                    
                default:
                    Text("Remaining tabs")
                }
            }
        }
    }
}
