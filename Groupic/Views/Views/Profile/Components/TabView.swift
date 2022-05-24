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
            HStack(spacing: 15) {
                Spacer()
                
                Text(user!.name)
                    .font(.title3)
                    .foregroundColor(.white)
                    .frame(alignment: .center)
                
                Spacer()
            }
            .padding()
            .background(Color("AccentColor"))
            
            HStack() {
                Spacer()
                
                Button(action: {
                    self.next.toggle()
                }, label: {
                    Image(systemName: "line.horizontal.3")
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
                    
                    checkIfCheckedEvent { result in
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
    
    func checkIfCheckedEvent(completion: @escaping ((Bool) -> () )) {
        ProfileService.followersEventCheck(userId: user!.uid).getDocuments() {
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

