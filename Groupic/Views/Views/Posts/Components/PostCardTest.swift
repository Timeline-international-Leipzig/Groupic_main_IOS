//
//  PostCardImage.swift
//  Groupic
//
//  Created by Anatolij Travkin on 12.01.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardTest: View {
    var postModel: PostModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                WebImage(url: URL(string: postModel.mediaUrl)!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 60, height: 60, alignment: .center)
                    .shadow(color: .gray, radius: 3)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(postModel.username).font(.headline)
                    Text((Date(timeIntervalSince1970: postModel.dateN))
                            .timeAgo())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
            }
            .padding(.leading)
            .padding(.top, 16)
            
            WebImage(url: URL(string: postModel.mediaUrl)!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: getRectView().width, height: 400, alignment: .center)
                .clipped()
        }
    }
}

