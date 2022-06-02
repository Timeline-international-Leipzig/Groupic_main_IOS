//
//  HighlightPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//

import SwiftUI
import Firebase

struct FutureSearchUserPostView: View {
    @StateObject var profileService = ProfileService()
    
    @State var user: UserModel
    @State var exists = false

    @State var date = Date()
    
    var userCollection = Firestore.firestore().collection("events")
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Es gibt aktuell noch keine zukünftigen Ereignisse")
                }
                
                VStack {
                    ForEach(self.profileService.posts, id: \.id) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if (postUid.postId == post.id)  && post.startDate > date {
                                VStack {
                                    UserPostCardView(postModel: post, userModel: user, exist: $exists)
                                }
                                .onAppear {
                                    checkIfUserExists(userId: Auth.auth().currentUser!.uid, postId: post.id) { result in
                                        if (result == true) {
                                            self.exists = true
                                        }
                                        else {
                                            self.exists = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .background(Color(.white))
            }
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.allPosts(userId: user.uid)
            self.profileService.loadUserPosts(userId: user.uid)
        }
    }
    
    func checkIfUserExists(userId: String, postId: String, completion: @escaping ((Bool) -> () )) {
        self.userCollection.document(postId).collection("participants").whereField("uid", isEqualTo: userId).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is a user")
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
