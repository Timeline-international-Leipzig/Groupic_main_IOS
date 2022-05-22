//
//  Test.swift
//  Groupic
//
//  Created by Anatolij Travkin on 15.01.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCardView: View {
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
                        
                        ZStack {
                            //Kreis
                            
                            HStack {
                                VStack {
                                    Image(systemName: "circle")
                                        .foregroundColor(.white)
                                        .font(.system(size: 10))
                                    
                                    Color.white.frame(width: CGFloat(2) / UIScreen.main.scale)
                                }.offset(x: -5)
                                
                                Spacer()
                            }
                            
                            HStack {
                            
                            Text((Date(timeIntervalSince1970: postModel.dateN))
                                .timeAgo())
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .frame(alignment: .topLeading)
                            .offset(y: -5)
                            .padding(.leading, 20)
                            
                            Spacer()
                                
                            }
                        }.padding(.horizontal)
                    }
                      
                       //Linie
                       
                   }
                   
                   Spacer()
                   
                   HighlightButton(post: postModel, highlightCheck: $postModel.highlighted).padding(.trailing, 10)
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
                       
                       ZStack {
                           
                           HStack {
                               Color.white.frame(width:CGFloat(2) / UIScreen.main.scale, height: 40)
                                   //.offset(y: -8)
                               
                               Spacer()
                           }
                           
                           HStack {
                               
                               Text(postModel.caption)
                                   .foregroundColor(.white)
                                   .font(.title3)
                                   .padding(.leading, 20)
                                   //.frame(width: 320, height: 40, alignment: .topLeading)
                               
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
                       }
                   }.padding(.horizontal)
                       .offset(y: -6)
               }
               .offset(y: -10)
           }
    }
}
    


