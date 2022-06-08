//
//  UserMidTabBar.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.03.22.
//

import SwiftUI
import Firebase

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
                                    .foregroundColor(Color(.white))
                                    .scaledToFill()
                                    .minimumScaleFactor(0.5)
                                    .lineLimit(1)
                                
                            }
                        }
                        
                        else {
                            Text(tabBarImageName[num])
                                .foregroundColor(.white)
                                .scaledToFill()
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)                        }
                    })
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
                    if user.uid != Auth.auth().currentUser!.uid {
                        UserHighlightPostView(user: user)
                            .padding(.top, 30)
                    }
                    else {
                        HighlightPostView()
                            .padding(.top, 30)
                    }
                    
                case 1:
                    
                    if user.uid != Auth.auth().currentUser!.uid {
                        SearchUserPostView(user: user)
                            .padding(.top, 30)
                    }
                    else {
                        UserPostView()
                            .padding(.top, 30)
                    }
                    
                case 2:
                    if user.uid != Auth.auth().currentUser!.uid {
                        
                        FutureSearchUserPostView(user: user)
                            .padding(.top, 30)
                    }
                    else {
                        FutureUserPostView()
                            .padding(.top, 30)
                    }
                    
                case 3:
                    if user.uid != Auth.auth().currentUser!.uid {
                        
                        UserContactsView(user: user)
                            .padding(.top, 30)
                    }
                    else {
                        ContactsView()
                            .padding(.top, 30)
                    }
                    
                default:
                    Text("Remaining tabs")
                }
            }
        }
        .padding(.top, 20)
    }
}
