//
//  SocialUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.04.22.
//

import SwiftUI
import Firebase

struct SocialUserPostView: View {
    @StateObject var profileService = ProfileService()
    @State var user: UserModel
    @State var posts: PostModel
    
    var userCollection = Firestore.firestore().collection("events")
    
    @State var exists = false
    
    var body: some View {
        VStack {
            SocialPostCardView(postModel: posts, userModel: user, exist: $exists)
            //PostCardView(postModel: post)
            //PostCardBottomView(postModel: post)
        }
        .background(Color("mainColor"))
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            checkIfUserExists(userId: Auth.auth().currentUser!.uid, postId: posts.postId) { result in
                if (result == true) {
                    self.exists = true
                }
                else {
                    self.exists = false
                }
            }
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

