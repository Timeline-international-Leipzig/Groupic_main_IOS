//
//  HighlightPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//

import SwiftUI
import Firebase

struct SearchUserPostView: View {
    @StateObject var profileService = ProfileService()
    
    @State var user: UserModel
    @State var exists = false

    
    var userCollection = Firestore.firestore().collection("events")
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Noch keine Ereignisse")
                        .font(.custom("Inter-Regular", size: 16))
                }.padding(.top, 30)
                
                VStack(spacing: 1) {
                    ForEach(self.profileService.posts, id: \.id) {
                        (post) in
                        
                        ForEach(profileService.postsUid, id: \.postId) {
                            (postUid) in
                            
                            if postUid.postId == post.id {
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
                }.padding(.bottom, 100)
            }
        }
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
