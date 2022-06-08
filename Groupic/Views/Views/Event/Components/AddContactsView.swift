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
    
    var userCollection = Firestore.firestore().collection("events")
    
    @Binding var back: Bool
    @Binding var post: PostModel
    
    @State var error = "Teilnehmer hinzufügen"

    @State var alert = false
    
    var body: some View {
        
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(Color.white)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    ScrollView {
                        ZStack {
                            VStack {
                                Text("Noch keine Kontakte").foregroundColor(.white)
                            }
                        
                        VStack {
                            ForEach(profileService.users, id: \.uid) {
                                (user) in
                                
                                ForEach(profileService.followUsers, id: \.uid) {
                                    (users) in
                                    
                                    if user.uid == users.uid {
                                            VStack {
                                                EventContactsView(user: user, post: post)
                                            }
                                        }
                                    }
                                }
                        }
                        }
                    }
                    .navigationTitle("")
                    .navigationBarHidden(true)
                    .onAppear {
                        self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
                        self.profileService.loadUser(userId: Auth.auth().currentUser!.uid)
                        self.profileService.loadAllEventUsers(postId: post.id)
                    }
                    
                    Button(action: {
                        self.back.toggle()
                    }, label: {
                        Text("Schließen")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color("buttonText"))
                            .padding(5)
                            .background(
                                Color("buttonColor")
                                    .cornerRadius(5)
                            )
                    }).padding()
                }
                .frame(width: UIScreen.main.bounds.width - 50)
                .frame(height: UIScreen.main.bounds.height - 200)
                .background(Color.black.opacity(0.95))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .padding(.top, 100)
                
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



