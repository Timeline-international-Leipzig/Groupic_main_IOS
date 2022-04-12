//
//  HighlightButtonSwitched.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//

//
//  HighlightButton.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//


import SwiftUI
import Firebase

struct HighlightButtonSwitched: View {
    @EnvironmentObject var session: SessionStore
    
    var post: PostModel
    
    @Binding var highlightCheck: Bool
    
    init(post: PostModel, highlightCheck: Binding<Bool>) {
        self.post = post
        self._highlightCheck = highlightCheck
    }

    func highlight() {
        if !self.highlightCheck {
            PostService.highlightPost(userId: self.session.session!.uid, postId: post.postId, highlight: highlightCheck) {}
            
            self.highlightCheck = true
        } else {
            PostService.highlightPost(userId: self.session.session!.uid, postId: post.postId, highlight: highlightCheck) {}
            
            self.highlightCheck = false
        }
    }
    
    var body: some View {
        Button(action: {
            self.highlight()
        }, label: {
            Text((self.highlightCheck) ? Image(systemName: "star.fill"): Image(systemName: "star"))
                .background(Color.gray)
                .foregroundColor(.black)
        })
    }
}


