//
//  EventView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct EventViewOnlyContactView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @State var postModel: PostModel
    @Binding var userModel: UserModel
    @Binding var next: Bool
    
    @State var showparticipants = false
    
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
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                        // do your stuff when pulled
                    }
                    
                    VStack {
                        if postModel.mediaUrl == "" {
                            Image("grey")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRectView().width, height: 180, alignment: .center)
                                .cornerRadius(0)
                        }
                        else {
                            WebImage(url: URL(string: postModel.mediaUrl))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRectView().width, height: 180, alignment: .center)
                                .cornerRadius(0)
                        }
                        
                        HStack {
                            Image(systemName: "line.horizontal.3")
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                            
                            Spacer()
                            
                            Text(postModel.caption)
                                .font(.system(size: 26, weight: .bold, design: .default))
                            
                            Spacer()
                            
                        }.padding(.horizontal)
                        
                        HStack {
                            if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                Spacer()
                                
                                Text(postModel.startDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(alignment: .topLeading)
                                
                                Spacer()
                            }
                            
                            else {
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
                        .foregroundColor(.secondary)
                        .padding(-10)
                        
                        Text("Mit:")
                            .foregroundColor(.secondary)
                            .padding(10)
                        
                        ZStack {
                            EventUserPicsView(post: $postModel, showparticipants: $showparticipants)
                        }
                        
                        .padding(.top)
                        
                        Divider()
                            .padding(.top)
                        
                        EventsContentView(postModel: $postModel, userModel: $userModel)
                    }
                }.offset(y: -17)
            }
            .background(Color.white)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
            if self.showparticipants {
                ParticipantsView(back: $showparticipants, post: $postModel)
            }
        }
    }
}
