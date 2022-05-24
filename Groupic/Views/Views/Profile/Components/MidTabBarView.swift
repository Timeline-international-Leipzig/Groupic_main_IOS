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
            HStack(alignment: .center, spacing: 20) {
                ForEach(0..<4) {
                    num in
                    
                    Button(action: {
                        withAnimation(.easeInOut) {
                            
                            selectedIndex = num
                        }
                    }, label: {
                        if num == selectedIndex {
                            ZStack {
                                Text(tabBarImageName[num])
                                    .foregroundColor(Color("AccentColor"))
                                
                                Rectangle()
                                    .fill(Color("AccentColor"))
                                    .frame(width: 68, height: 1, alignment: .center)
                                    .offset(y: 15)
                            }
                        }
                        
                        else {
                            Text(tabBarImageName[num])
                                .foregroundColor(.black)
                        }
                    }
                    )
                }
            }
            
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
        .padding(.top, 20)
    }
}
