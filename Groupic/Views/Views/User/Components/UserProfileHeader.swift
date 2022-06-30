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
                if user!.titleImageId == "" {
                    Image("grey")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
                else {
                    WebImage(url: URL(string: user!.titleImageId))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
                
                
                HStack {
                    Text(user!.username).bold()
                    
                    Spacer()
                    
                    if user!.uid == session.session!.uid {
                        Button(action: {
                            self.nextProfile.toggle()
                        }, label: {
                            Text("Bearbeiten")
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
                .padding()
            }
            
            VStack {
                if user!.profileImageId == "" {
                    Image("profileImage")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                }
                else {
                    WebImage(url: URL(string: user!.profileImageId))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .clipShape(Circle())
                        
                }
            }.offset(y: 60)
        }
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


