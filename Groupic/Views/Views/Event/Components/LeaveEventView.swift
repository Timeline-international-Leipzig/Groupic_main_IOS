//
//  deleteEventView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 01.05.22.
//

import SwiftUI

import SwiftUI
import Firebase

struct LeaveEventView: View {
    @ObservedObject var followService = FollowService()
    
    @Binding var back: Bool
    @Binding var backCompleteDelete: Bool
    
    @State var error = "Willst du das Ereignis wirklich verlassen?"
    
    @State var alert = false
    
    @Binding var userModel: UserModel
    @Binding var postModel: PostModel
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(Color.black)
                        .padding(.top)
                        .padding(.horizontal, 25)
                        .frame(alignment: .center)
                    
                    Button(action: {
                        checkIfCheckedEvent { result in
                            if (result == true) {
                                followService.deInvite(userId: Auth.auth().currentUser!.uid, postId: postModel.id)
                                self.backCompleteDelete.toggle()
                            }
                            else {
                                followService.delete(userId: userModel.uid, postId: postModel.id)
                                self.backCompleteDelete.toggle()
                            }
                        }
                    }, label: {
                        Text("Verlassen")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.top, 25)
                    
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
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
    
    func checkIfCheckedEvent(completion: @escaping ((Bool) -> () )) {
        ProfileService.followersPostEventCheck(postId: postModel.id).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count >= 2) {
                    print(QuerySnapshot!.count)
                    completion(true)
                }
                else {
                    print(QuerySnapshot!.count)
                    completion(false)
                }
            }
        }
    }
}



