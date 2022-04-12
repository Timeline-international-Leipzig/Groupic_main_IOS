//
//  HighlightPostCardView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 09.04.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HighlightPostCardView: View {
    @State var postModel: PostModel
    @State var next = false
    @State var date = Date()
    
       var body: some View {
           if postModel.highlighted == true {
           
           NavigationLink(destination: EventView(postModel: $postModel, next: $next), isActive: self.$next, label: {
               EmptyView()
           })
           
           VStack () {
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
                               Spacer()
                               
                               Text(postModel.startDate, style: .date)
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                                   .frame(alignment: .topLeading)
                                   .offset(y: -10)
                               
                               Text(" - ")
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                                   .frame(alignment: .topLeading)
                                   .offset(y: -10)

                               
                               Text(postModel.endDate, style: .date)
                                   .font(.subheadline)
                                   .foregroundColor(.gray)
                                   .frame(alignment: .topLeading)
                                   .offset(y: -10)
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
           else {
              Text("Noch keine Highlights")
           }
    }
}
    
