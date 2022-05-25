//
//  HighlightPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//

import SwiftUI
import Firebase

struct UserHighlightPostView: View {
    @StateObject var profileService = ProfileService()
    
    @State var user: UserModel
    @State var exists = false
    
    var userCollection = Firestore.firestore().collection("events")
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Es gibt aktuell noch keine Highlights")
                }
                
                VStack {
                    ForEach(self.profileService.posts, id: \.postId) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if (postUid.postId == post.postId) && post.highlighted == true {
                                VStack {
                                    UserPostCardView(postModel: post, userModel: user, exist: $exists)
                                }
                                .onAppear {
                                    checkIfUserExists(userId: Auth.auth().currentUser!.uid, postId: post.postId) { result in
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
