//
//  TabView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 14.01.22.
//

import SwiftUI
import Firebase

struct TabView: View {
    
    
    @State var nextNotifications = false
    @State var eventNew = false
    @State var new = false
    
    var user: UserModel?
    
    @Binding var x: CGFloat
    
    var body: some View {
        
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
            }
            
            VStack{
                HStack() {
                    
                    Spacer()
                    
                    Button(action: {
                        self.nextNotifications.toggle()
                    }, label: {
                        if new == true || eventNew == true {
                            Image(systemName: "envelope.badge")
                                .foregroundColor(.white)
                        }
                        else {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                        }
                    })
                    .padding(.horizontal)
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
                                    self.eventNew = true
                                }
                                else {
                                    self.eventNew = false
                                }
                            }
                        }
                    }
                    
                    Text(user!.fullName)
                        .font(.title3)
                        .foregroundColor(.white)
                        .frame(alignment: .center)
                    
                    Button(action: {
                        
                        withAnimation{
                            
                            x = 0
                        }
                        
                    }, label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white )
                    }).padding(.horizontal)
                    //.contentShape(Rectangle())
                    //.background(Color("mainColor"))
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.top, 50)
        }
        .ignoresSafeArea()
    }
    
    func checkIfChecked(completion: @escaping ((Bool) -> () )) {
        ProfileService.followersCheck(userId: user!.uid).addSnapshotListener() {
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
        ProfileService.followersEventCheck(userId: user!.uid).addSnapshotListener() {
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

