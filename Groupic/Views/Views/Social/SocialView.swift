//
//  SocialEndView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 26.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct SocialView: View {
    @StateObject var profileService = ProfileService()
    
    @State var isLoading = false
    @State var followCheck = false
    
    @State private var value: String = ""
    @State var users: [UserModel] = []
    @State var currentUser: UserModel?
    
    @State var next = false
    
    @State var nextNotifications = false
    @State var new = false
    @State var eventNew = false
    
    var user: UserModel?
    
    var body: some View {
        
        /*NavigationLink(destination: SettingsView(next: $next), isActive: self.$next, label: {
            EmptyView()
        })*/
        
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
                HStack {
                    
                    Spacer()
                    
                    Button(action: {},
                           label: {
                        if new == true || eventNew == true {
                            Image(systemName: "envelope.badge.fill")
                                .foregroundColor(.white)
                        }
                        else {
                            Image(systemName: "envelope")
                                .foregroundColor(.white)
                        }
                    })
                    /*.onAppear{
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
                    }*/
                    
                    Text("Community")
                        .font(.custom("Inter-Regular", size: 20))
                        .foregroundColor(.white)
                        .padding(.horizontal, 20)
                    
                    Button(action: {},
                           label: {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                        
                    })
                    
                    Spacer()
                    
                }.padding(.top, 50)
                
                Spacer()
            }.zIndex(1)
            
            VStack {

                ScrollView {
                    
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                        // do your stuff when pulled
                    }
                    
                    VStack(alignment: .leading) {
                        SearchBar(value: $value)
                            .onChange(of: value, perform: {
                                new in
                                
                                searchUsers()
                            })
                    }
                    .padding(.horizontal)
                    .padding(.top, 80)
                    
                    ZStack {
                        VStack {
                            Text("Unsozial").font(.custom("Inter-Regular", size: 16))
                        }
                        
                        SocialFriendsEventsView().padding(.bottom, 100)
                        
                        VStack(spacing: 0) {
                            if !isLoading || self.value != "" {
                                ForEach(users, id: \.uid) {
                                    user in
                                    
                                    HStack {
                                        Button(action: {
                                            self.currentUser = user
                                            
                                            next.toggle()
                                        }, label: {
                                            HStack {
                                                if user.profileImageId == "" {
                                                    Image("profileImage")
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 50, height: 50, alignment: .center)
                                                        .clipShape(Circle())
                                                        .padding()
                                                }
                                                else {
                                                    WebImage(url: URL(string: user.profileImageId))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 50, height: 50, alignment: .center)
                                                        .clipShape(Circle())
                                                        .padding()
                                                }
                                                
                                                Text(user.username)
                                                    .foregroundColor(.white)
                                                    .font(.subheadline)
                                                    .bold()
                                                
                                                Spacer()
                                                
                                                /*
                                                 if (user.uid == Auth.auth().currentUser!.uid) {
                                                 } else {
                                                 HStack {
                                                 FollowButton(user: user, followCheck: $profileService.followCheck, followingCount:    $profileService.following, followersCount: $profileService.follower)
                                                 .padding(.horizontal)
                                                 }
                                                 .onAppear {
                                                 self.profileService.followStateUser(userId: user.uid)
                                                 }
                                                 }
                                                 */
                                            }
                                            .padding(.horizontal)
                                        })
                                    }
                                }
                                
                                Spacer()
                                
                                NavigationLink(destination: UserProfileView(user: $currentUser, next: $next), isActive: self.$next, label: {
                                    EmptyView()
                                })
                            }
                        }
                        .offset(y: -10)
                        .background(Color("mainColor"))
                    }
                }
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .navigationBarHidden(true)
            }
            .background(Color("mainColor"))
        }
    }
    
    func searchUsers() {
        isLoading = true
        
        SearchService.searchUser(input: value) {
            (users) in
            
            self.isLoading = false
            self.users = users
        }
    }
    
    /*func checkIfChecked(completion: @escaping ((Bool) -> () )) {
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
    }*/
    
    /*func checkIfCheckedEvent(completion: @escaping ((Bool) -> () )) {
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
    }*/
}
