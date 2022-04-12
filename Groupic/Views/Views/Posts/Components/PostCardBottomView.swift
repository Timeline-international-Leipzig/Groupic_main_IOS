//
//  PostCardBottom.swift
//  Groupic
//
//  Created by Anatolij Travkin on 12.01.22.
//

import SwiftUI

struct PostCardBottomView: View {
    @ObservedObject var postCardService = PostCardService()
    
    @State private var animate = false
    
    private let duration: Double = 0.3
    private var animationScale: CGFloat {
        postCardService.isLiked ? 0.9 : 1.1
    }
    
    init(postModel: PostModel) {
        self.postCardService.post = postModel
        self.postCardService.hasLikedPost()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 15) {
                Button(action: {
                    self.animate = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: {
                        self.animate = false
                        
                        if(self.postCardService.isLiked) {
                            self.postCardService.unlike()
                        }
                        
                        else {
                            self.postCardService.like()
                        }
                    })
                    
                }, label: {
                    Image(systemName: (self.postCardService.isLiked) ? "heart.fill" : "heart")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25, alignment: .center)
                        .foregroundColor((self.postCardService.isLiked) ? .red : .black)
                })
                .padding().scaleEffect(animate ? animationScale : 1)
                .animation(.easeIn(duration: duration))
                
                Spacer()
            }
            .padding(.leading, 16)
            
            if(self.postCardService.post.likeCount > 0) {
                Text("\(self.postCardService.post.likeCount) Gefällt mir")
                    .padding()
            }
        }
    }
}
