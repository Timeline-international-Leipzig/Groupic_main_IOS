//
//  AddContacts.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.05.22.
//

import SDWebImageSwiftUI
import SwiftUI
import Firebase

struct AddContactsView: View {
    @StateObject var profileService = ProfileService()
    @ObservedObject var followService = FollowService()
    @EnvironmentObject var session: SessionStore
    
    @State var userSelected: UserModel?
    @State var users: [UserModel] = []
    
    @State var next = false
    
    @Binding var back: Bool
    
    @State var error = "Teilnehmer hinzufügen"

    @State var alert = false
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(Color.white)
                        .font(.system(size: 20, weight: .bold))
                        .padding(.top)
                        .padding(.horizontal, 25)
                        .frame(alignment: .center)
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                Text("Noch keine Kontakte")
                            }
                        
                            VStack {
                            ForEach(profileService.users, id: \.uid) {
                                (user) in
                                
                                ForEach(profileService.followUsers, id: \.uid) {
                                    (users) in
                                    
                                    if user.uid == users.uid {
                                        Button(action: {
                                            self.userSelected = user
                                            
                                            next.toggle()
                                        }, label: {
                                            HStack {
                                                if user.profileImageUrl == "" {
                                                    Image("profileImage")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        .clipShape(Circle())
                                                        .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                                                }
                                                else {
                                                    WebImage(url: URL(string: user.profileImageUrl))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 30, height: 30, alignment: .center)
                                                        .clipShape(Circle())
                                                        .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                                                }
                          
                                                Text(user.userName)
                                                    .foregroundColor(.white)
                                                    .font(.subheadline)
                                                    .bold()
                          
                                                Spacer()
                                                
                                                VStack {
                                                Button(action: {
                                                    
                                                }, label: {
                                                    Text("Einladen")
                                                        .foregroundColor(.black)
                                                        .font(.system(size: 14, weight: .bold))
                                                        //.font(.headline)
                                                        .padding(5)
                                                        .background(
                                                            Color("lightBlue")
                                                                .cornerRadius(5)
                                                        )
                                                })
                                                }
                                            }
                                            .padding()
                                        })
                                    }
                            }
                            }
                            
                            NavigationLink(destination: UserProfileView(user: $userSelected, next: $next), isActive: self.$next, label: {
                                EmptyView()
                            })
                            }
                            .background(Color(.systemGray6).cornerRadius(5))
                            
                        }
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .onAppear {
                        self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
                        self.profileService.loadUser(userId: Auth.auth().currentUser!.uid)
                    }
                    
                    Button(action: {
                        self.back.toggle()
                    }, label: {
                        Text("Schließen")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                }
                .padding(.all, 25)
                .padding(.top, 10)
                .frame(width: UIScreen.main.bounds.width - 50)
                .background(Color.black.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 200)
                .padding(.top, 100)
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
}



