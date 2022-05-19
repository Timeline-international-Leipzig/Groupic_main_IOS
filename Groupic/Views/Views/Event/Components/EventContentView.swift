//
//  EventContentView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.05.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct EventContentView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @Binding var postModel: PostModel
    @Binding var userModel: UserModel

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {

            
            ForEach(profileService.compositionElements, id: \.self) {
                    elements in
                
                    LayoutImages(eventElements: elements, user: userModel).rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
            }
            

        }
        .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
        .padding(.top)
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllEventElements(postId: postModel.postId)
            self.profileService.loadCompositionElements(postId: postModel.postId)
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadAllEventUsers(postId: postModel.postId)
            }
        }
    }



