//
//  UserMidTabBar.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.03.22.
//

import SwiftUI

struct UserMidTabBarView: View {
    
    var user: UserModel
    
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
                    ProfileUserPostView(user: user)
                        .padding(.top)

                case 2:
                    FutureSearchUserPostView(user: user)
                        .padding(.top)

                case 3:
                    ProfileUserPostView(user: user)
                        .padding(.top)

                default:
                    Text("Remaining tabs")
                }
            }
        }
        .padding(.top, 20)
    }
}
