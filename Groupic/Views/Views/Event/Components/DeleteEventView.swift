//
//  deleteEventView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 01.05.22.
//

import SwiftUI

import SwiftUI
import Firebase

struct DeleteEventView: View {
    
    @Binding var back: Bool
    @Binding var backCompleteDelete: Bool
    
    @State var error = "Willst du das Ereignis wirklich löschen?"

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
                        StorageService.deletePost(userId: userModel.uid, postId: postModel.postId, onSuccess: {})
                        self.backCompleteDelete.toggle()
                    }, label: {
                        Text("Löschen")
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
}



