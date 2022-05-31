//
//  Test.swift
//  Groupic
//
//  Created by Anatolij Travkin on 15.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct PostCardView: View {
    @StateObject var profileService = ProfileService()
    
    @State var postModel: PostModel
    @State var userModel: UserModel
    @State var next = false
    
    var body: some View {
        NavigationLink(destination: EventView(postModel: $postModel, userModel: $userModel, next: $next), isActive: self.$next, label: {
            EmptyView()
        })
        
        VStack {
            HStack {
                VStack {
                    HStack {
                        //Kreis
                        VStack {
                            Image(systemName: "circle")
                                .foregroundColor(.gray)
                                .font(.system(size: 10))
                            
                            Color.gray.frame(width: CGFloat(2) / UIScreen.main.scale)
                        }
                        
                        Text((Date(timeIntervalSince1970: postModel.dateN))
                            .timeAgo())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .frame(alignment: .topLeading)
                        .offset(y: -5)
                    }
                    .padding(.horizontal)
                    
                    //Linie
                    
                }
                
                Spacer()
                
                HighlightButton(post: postModel, highlightCheck: $postModel.highlighted)
            }
            
            VStack {
                Button(
                    action: {
                        self.next.toggle()
                    },
                    label: {
                        
                        WebImage(url: URL(string: postModel.mediaUrl)!)
                            .resizable()
                            .frame(width: getRectView().width, height: 170, alignment: .center)
                            .clipped()
                    }
                )
                
                HStack {
                    Color.gray.frame(width:CGFloat(2) / UIScreen.main.scale)
                        .offset(y: -8)
                    
                    
                    ZStack {
                        HStack {
                            if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                Spacer()
                                
                                Text(postModel.startDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                            }
                            
                            else {
                                Spacer()
                                
                                Text(postModel.startDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                
                                Text(" - ")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                
                                Text(postModel.endDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                            }
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text(postModel.caption)
                                .font(.title3)
                                .frame(width: 320, height: 40, alignment: .topLeading)
                            
                            Spacer()
                        }
                    }
                }
                .padding(.horizontal)
            }
            .offset(y: -10)
        }
    }
}



