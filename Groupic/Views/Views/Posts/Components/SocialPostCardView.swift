//
//  SocialPostCardView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.04.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct SocialPostCardView: View {
    @StateObject var profileService = ProfileService()
    
    @State var postModel: PostModel
    @State var user: UserModel
    @State var next = false
    @State var date = Date()
    
    var body: some View {
        NavigationLink(destination: EventView(postModel: $postModel, userModel: $user, next: $next), isActive: self.$next, label: {
            EmptyView()
        })
        
        VStack {
            HStack {
                VStack {
                    HStack {
                        ZStack {
                            HStack {
                                //Kreis
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                    
                                    Color.white.frame(width: CGFloat(2) / UIScreen.main.scale)
                                }.offset(x: -5)
                                
                                Spacer()
                            }
                            
                            HStack {
                                
                                Text(user.userName)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                                    .offset(y: -5)
                                
                                Text("vor " + (Date(timeIntervalSince1970: postModel.dateN))
                                    .timeAgo())
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                                .offset(y: -5)
                                
                                Spacer()
                            }.padding(.leading, 20)
                        }.padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            
            VStack {
                Button(
                    action: {
                        self.next.toggle()
                    },
                    label: {
                        WebImage(url: URL(string: postModel.mediaUrl)!)
                            .resizable()
                            .frame(width: getRectView().width, height: 170)
                            .clipped()
                    }
                )
                
                HStack {
                    ForEach(profileService.eventElements.prefix(4), id: \.id){ item in
                        if item.type == "IMAGE" {
                            WebImage(url: URL(string: item.uriOrUid)!)
                                .resizable()
                                .frame(width: getRectView().width / 4.3, height: getRectView().width / 4.3)
                                .clipped()
                        }
                        else {
                        }
                    }
                }
                
                ZStack {
                    
                    HStack {
                        Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)
                        
                        Spacer()
                    }
                    
                    HStack {
                        
                        Text(postModel.caption)
                            .font(.title3)
                        //.frame(width: 320, height: 40, alignment: .topLeading)
                            .padding(.leading, 20)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        
                        Text(postModel.startDate, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.white)
                        //.frame(alignment: .topLeading)
                        //.offset(y: -10)
                        
                        Text(" - ")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        //.frame(alignment: .topLeading)
                        //.offset(y: -10)
                        
                        
                        Text(postModel.endDate, style: .date)
                            .font(.subheadline)
                            .foregroundColor(.white)
                        //.frame(alignment: .topLeading)
                        //.offset(y: -10)
                    }
                }.padding(.horizontal)
                    .offset(y: -6)
            }
            .offset(y: -10)
        }
        .onAppear {
            self.profileService.loadAllEventElements(postId: postModel.postId)
        }
    }
}
