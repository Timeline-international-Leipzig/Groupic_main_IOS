//
//  EventContentView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.05.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct EventsContentView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    @Binding var isLoading: Bool
    
    @Binding var postModel: PostModel
    @Binding var userModel: UserModel
    
    var body: some View {

        
        ScrollView(.vertical, showsIndicators: false) {
            ZStack {
                /*VStack {
                    Text("Noch kein Content")
                        .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                }*/
                
                VStack {
                    if isLoading == false {
                    ForEach(profileService.compositionElements, id: \.self) {
                        elements in
                        
                        LayoutImages(eventElements: elements, user: userModel)
                            .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
                    }
                    }
                }
            }
        }
        .background(Color("mainColor"))
        .rotationEffect(Angle(degrees: 180)).scaleEffect(x: -1.0, y: 1.0, anchor: .center)
        .padding(.top)
        .navigationTitle("")
        .onAppear {
            self.profileService.loadAllEventElements(postId: postModel.id)
            self.profileService.loadAllUser(userId: Auth.auth().currentUser!.uid)
            self.profileService.loadAllEventUsers(postId: postModel.id)
        }
    }
    
    func searchElments() {
        isLoading = true
        
        self.profileService.loadAllEventElements(postId: postModel.id)
        self.profileService.loadCompositionElements(postId: postModel.id)
        
        isLoading = false
    }
}



