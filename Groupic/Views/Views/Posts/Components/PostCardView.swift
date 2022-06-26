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
        
        VStack(spacing: 0) {
            ZStack {
                HStack {
                    //Kreis
                    VStack {
                        Image(systemName: "circle")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                        
                        Color.white.frame(width: CGFloat(2) / UIScreen.main.scale, height: 20)
                    }
                    
                    Text((Date(timeIntervalSince1970: postModel.publishTime))
                        .timeAgo())
                    .font(.custom("Inter-Regular", size: 12))
                    .foregroundColor(.white)
                    .frame(alignment: .topLeading)
                    
                    
                    Spacer()
                }.padding(.leading, 5)
                //Linie
                
                HStack {
                    
                    Spacer()
                    
                    HighlightButton(post: postModel, highlightCheck: $postModel.highlighted)
                }
            }
            
            VStack(spacing: 0) {
                Button(
                    action: {
                        self.next.toggle()
                    },
                    label: {
                        
                        WebImage(url: URL(string: postModel.coverPic)!)
                            .resizable()
                            .frame(width: getRectView().width, height: 200, alignment: .center)
                            .clipped()
                    }
                )
                
                HStack {
                    
                    ZStack {
                        HStack {
                            if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                
                                Spacer()
                                
                                Text(postModel.startDate, style: .date)
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(.white)
                            }
                            
                            else {
                                Spacer()
                                
                                Text(postModel.startDate, style: .date)
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                                
                                Text("-")
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                                
                                Text(postModel.endDate, style: .date)
                                    .font(.custom("Inter-Regular", size: 12))
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                            }
                        }.padding(.trailing, 10)
                        
                        HStack {
                            
                            Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)
                            
                            Text(postModel.title)
                                .font(.custom("Inter-Regular", size: 20))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }.padding(.leading, 10)
                    }
                }
            }
        }.background(Color("mainColor"))
    }
}



