//
//  AddContacts.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.05.22.
//

import SDWebImageSwiftUI
import SwiftUI
import Firebase

struct ParticipantsView: View {
    @StateObject var profileService = ProfileService()
    @ObservedObject var followService = FollowService()
    @EnvironmentObject var session: SessionStore
    
    var userCollection = Firestore.firestore().collection("events")
    
    @Binding var back: Bool
    @Binding var post: PostModel
    
    @State var error = "Teilnehmer"
    
    @State var alert = false
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text("Admins")
                        .foregroundColor(Color.black)
                        .padding(.top)
                        .padding(.horizontal, 25)
                        .frame(alignment: .center)
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                ForEach(profileService.users, id: \.uid) {
                                    (user) in
                                    
                                    ForEach(profileService.usersUid, id: \.uid) {
                                        (users) in
                                        
                                        if user.uid == users.uid {
                                            VStack {
                                                ShowAdminsView(user: user, post: post)
                                            }
                                        }
                                    }
                                }
                            }
                            .background(Color(.systemGray6))
                        }
                    }
                    
                    Text(self.error)
                        .foregroundColor(Color.black)
                        .padding(.top)
                        .padding(.horizontal, 25)
                        .frame(alignment: .center)
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                ForEach(profileService.users, id: \.uid) {
                                    (user) in
                                    
                                    ForEach(profileService.usersUid, id: \.uid) {
                                        (users) in
                                        
                                        if user.uid == users.uid {
                                            VStack {
                                                ShowParticipantView(user: user, post: post)
                                            }
                                        }
                                    }
                                }
                            }
                            .background(Color(.systemGray6))
                        }
                    }
                    
                    Spacer()
                    
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
                .frame(width: UIScreen.main.bounds.width - 90)
                .background(Color.white.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                .navigationTitle("")
                .onAppear {
                    self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
                    self.profileService.loadAllEventUsers(postId: post.id)
                }
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
    
    //Next View & Error Check
    func checkIfEmailOfAccountExists(postId: String, uid: String, completion: @escaping ((Bool) -> () )) {
        self.userCollection.document(postId).collection("participants").whereField("uid", isEqualTo: uid).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is already a user with this email")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
}



