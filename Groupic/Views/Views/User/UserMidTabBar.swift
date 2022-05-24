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
        
        VStack {
            
            HStack {
                
                ForEach(0..<4) {num in
                    
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
            ).padding(.bottom, 20)
                .padding(.top, 20)
            
            ZStack{
                
                switch selectedIndex {
                case 0:
                    
                    UserHighlightPostView(user: user)
                    
                case 1:
                    
                    SearchUserPostView(user: user)
                    
                case 2:
                    
                    FutureSearchUserPostView(user: user)
                    
                case 3:
                    
                    UserContactsView(user: user)
                    
                default:
                    Text("Remaining tabs")
                    
                }
            }
        }
        
        
        /*VStack(spacing: 0) {
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
                    UserHighlightPostView(user: user)
                        .padding(.top)
                    
                case 1:
                    SearchUserPostView(user: user)
                        .padding(.top)

                case 2:
                    FutureSearchUserPostView(user: user)
                        .padding(.top)

                case 3:
                    UserContactsView(user: user)
                        .padding(.top)

                default:
                    Text("Remaining tabs")
                }
            }
        }
        .padding(.top, 20)*/
    }
}
