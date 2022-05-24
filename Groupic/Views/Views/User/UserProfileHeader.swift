//
//  UserProfileHeader.swift
//  Groupic
//
//  Created by Anatolij Travkin on 18.03.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct UserProfileHeader: View {
    var user: UserModel?
    
    @EnvironmentObject var session: SessionStore
    @ObservedObject var followService = FollowService()
    @StateObject var profileService = ProfileService()
    
    @State var nextProfile = false
    
    @State var new = false
    
    var body: some View {
        ZStack {
            
            VStack {
                if user!.backgroundImageUrl == "" {
                    Image("grey")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
                else {
                    WebImage(url: URL(string: user!.backgroundImageUrl))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
                
                
                HStack {
                    Text(user!.userName)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    if user!.uid == session.session!.uid {
                        Button(action: {
                            self.nextProfile.toggle()
                        }, label: {
                            Text("Profil Bearbeiten")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(Color(.white))
                                .font(.headline)
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        })
                    }
                    
                    else {
                        HStack {
                            if new == true {
                                Button(action: {
                                    followService.deleteContact(userId: user!.uid)
                                }, label: {
                                    Text("Entfernen")
                                        .font(.system(size: 12, weight: .bold))
                                        .foregroundColor(Color(.white))
                                        .font(.headline)
                                        .padding(5)
                                        .background(
                                            Color("buttonColor")
                                                .cornerRadius(5)
                                        )
                                })
                            }
                            else {
                           FollowButton(user: user!, followCheck: $profileService.followCheck, followingCount:    $profileService.following, followersCount: $profileService.follower)
                            }
                        }
                        .onAppear {
                            self.profileService.followStateUser(userId: user!.uid)
                            
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
                .padding(.horizontal, 8)
                    .padding(.vertical, 20)
            }
            
            ZStack {
                VStack {
                    if user!.profileImageUrl == "" {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                    }
                    else {
                        WebImage(url: URL(string: user!.profileImageUrl))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 125, height: 125, alignment: .center)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color("AccentColor"), lineWidth: 0.5))
                    }
                }
            }
            .offset(y: 60)
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    func checkIfChecked(completion: @escaping ((Bool) -> () )) {
        ProfileService.contactCheck(userId: session.session!.uid).whereField("uid", isEqualTo: user!.uid).getDocuments() {
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


