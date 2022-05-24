//
//  TabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.01.22.
//

import SwiftUI
import Firebase

struct TabView: View {
    
    @State var next = false
    @State var nextNotifications = false
    @State var new = false
    
    var user: UserModel?
    
    var body: some View {
        
        NavigationLink(destination: SettingsView(next: $next), isActive: self.$next, label: {
            EmptyView()
        })
        
        NavigationLink(destination: NotificationsView(back: $nextNotifications), isActive: self.$nextNotifications, label: {
            EmptyView()
        })
        
        ZStack {
            
            VStack {
                HStack(spacing: 15) {
                    Spacer()
                    
                    HStack {
                        
                        Button(action: {
                            self.nextNotifications.toggle()
                        }, label: {
                            if new == true {
                                Image(systemName: "envelope.badge.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                            else {
                                Image(systemName: "envelope.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            }
                        })
                    }
                    .padding(.horizontal)
                    .onAppear{
                        checkIfChecked { result in
                            if (result == true) {
                                self.new = true
                            }
                            else {
                                self.new = false
                            }
                        }
                    }
                    
                    Text(user!.name)
                        .font(.title3)
                        .foregroundColor(.white)
                    
                    Button(action: {
                        self.next.toggle()
                    },
                           label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                    }).padding(.horizontal)
                    
                    Spacer()
                }.padding(.top, 50)
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    ).colorInvert()
                
                Spacer()
            }
        }
    }
    
    func checkIfChecked(completion: @escaping ((Bool) -> () )) {
        ProfileService.followersCheck(userId: user!.uid).whereField("globalCheck", isEqualTo: false).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("new message")
                    completion(true)
                }
                else {
                    print("no new message")
                    completion(false)
                }
            }
        }
    }
}

