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
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    ).colorInvert()
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                HStack(spacing: 15) {
                    Spacer()
                    
                    Button(action: {},
                           label: {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 20))
                        
                    }).padding(.horizontal, 20)
                    
                    Text(user!.name)
                        .font(.title3)
                        .foregroundColor(.white)
                })
            }
            .padding()
            
            HStack() {
                Button(action: {
                    self.nextNotifications.toggle()
                }, label: {
                    if new == true {
                        Image(systemName: "paperplane.circle.fill")
                            .foregroundColor(.white)
                    }
                    else {
                        Image(systemName: "paperplane.circle")
                            .foregroundColor(.white)
                    }
                })
                
                Spacer()
            }
            .padding()
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

