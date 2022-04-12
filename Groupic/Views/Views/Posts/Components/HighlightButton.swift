//
//  HighlightButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//


import SwiftUI
import Firebase

struct HighlightButton: View {
    @EnvironmentObject var session: SessionStore
    
    var post: PostModel
    
    @Binding var highlightCheck: Bool
    
    init(post: PostModel, highlightCheck: Binding<Bool>) {
        self.post = post
        self._highlightCheck = highlightCheck
    }

    func highlight() {
        if !post.highlighted {
            self.highlightCheck = true
            
            PostService.highlightPost(userId: self.session.session!.uid, postId: post.postId, highlight: highlightCheck) {}
        } else {
            self.highlightCheck = false
            
            PostService.highlightPost(userId: self.session.session!.uid, postId: post.postId, highlight: highlightCheck) {}
        }
    }
    
    var body: some View {
        Button(action: {
            self.highlight()
        }, label: {
            Text((post.highlighted) ? Image(systemName: "star.fill"): Image(systemName: "star"))
                .background(Color.gray)
                .foregroundColor(.black)
        })
    }
}

