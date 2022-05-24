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
    @State var textFieldText: String = ""
    
    let tabBarImageName = ["Highlights","Ereignisse","Anstehend","Kontakte"]
    
    var body: some View{
        
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
            )
            
            HStack{
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.white)
                    .font(.system(size: 18))
                    .padding(.leading, 15)

                
                TextField(" ", text: $textFieldText)
                    .padding(.all, 5)
                    .accentColor(.white)
                    .background(Color("mainColor"))
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .padding()
                
            }.padding(.horizontal)
            
            Divider()
                .background(Color.white)
                .padding(.horizontal, 18)
                .offset(y: -12)
            
            ZStack{
                
                switch selectedIndex {
                case 0:
                    
                    HighlightPostView()
                    
                case 1:
                    
                    UserPostView()
                    
                case 2:
                    
                    FutureUserPostView()
                    
                case 3:
                    
                    ContactsView()
                    
                default:
                    Text("Remaining tabs")
                    
                }
            }
        }
    }
}

