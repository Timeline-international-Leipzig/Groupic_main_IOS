//
//  EventView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.01.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventView: View {
    @StateObject var profileService = ProfileService()
    
    @Binding var postModel: PostModel
    @Binding var next: Bool
    
    var body: some View {
        ZStack {
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
            
            VStack {
                HStack() {
                    Button(action: {
                        self.next.toggle()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                    })
                    
                    Spacer()
                }
                .padding()
                .background(Color("AccentColor"))
                
                ScrollView {
                    WebImage(url: URL(string: postModel.mediaUrl)!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                    
                    HStack {
                        Image(systemName: "line.horizontal.3")
                            .foregroundColor(.white)
                            .font(.system(size: 20))

                        
                        Spacer()
                        
                        Text(postModel.caption)
                            .font(.system(size: 26, weight: .bold, design: .default))
                        
                        Spacer()
                        
                        DropDownMenu()
                        
                    }.padding(.horizontal)
                    
                    HStack {
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
                        .foregroundColor(.secondary)
                        .padding(-10)
                    
                    FollowEventButton(post: postModel, followCheck: $profileService.followCheck)
                        .padding()
                    
                    Text("Mit:")
                        .foregroundColor(.secondary)
                        .padding(10)
                    
                    HStack {
                        
                        Spacer()
                        
                       //HorizontalList()
                        
                        Spacer()
                        
                        Button(action: {}, label: {
                            Image(systemName: "person.crop.circle.badge.plus")
                            .foregroundColor(.black)
                            .font(.system(size: 20))
                        })
                    }
                    .padding(.horizontal)
                    
                    //InEventBilderButton()
                    
                    Pictures()
                        .padding(1)
                    
                }.offset(y: -8)
            }
            .background(Color.white)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
        }
    }
}

