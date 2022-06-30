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
    
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            
            VStack {
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                    ).colorInvert()
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
            }.zIndex(1)
            
            VStack {
                ZStack {
                    HStack {
                        
                        Spacer()
                        
                        Text(postModel.title)
                            .font(.system(size: 26, weight: .bold, design: .default))
                        
                        Spacer()
                    }.padding(.top, 50)
                }
                
                Spacer()
            }.zIndex(1)
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                        // do your stuff when pulled
                    }
                    
                    VStack {
                        if postModel.coverPic == "" {
                            Image("grey")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRectView().width, height: 180, alignment: .center)
                                .cornerRadius(0)
                        }
                        else {
                            WebImage(url: URL(string: postModel.coverPic))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: getRectView().width, height: 180, alignment: .center)
                                .cornerRadius(0)
                        }
                        
                        HStack {
                            if Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                
                                Spacer()
                                
                                Text(postModel.startDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                                
                                Spacer()
                            }
                            
                            else {
                                Text(postModel.startDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                                
                                Text("-")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                                
                                Text(postModel.endDate, style: .date)
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                    .frame(alignment: .topLeading)
                            }
                        }
                        
                        Text("Mit:")
                            .foregroundColor(.white)
                            .padding(.top, 5)
                        
                        ZStack {
                            EventUserPicsView(post: $postModel, showparticipants: $showparticipants)
                        }.padding(.top)
                        
                        EventsContentView(isLoading: $isLoading, postModel: $postModel, userModel: $userModel)
                    }
                }.offset(y: -17)
            }
            
            if self.showparticipants {
                ParticipantsView(back: $showparticipants, post: $postModel)
            }
        }
        .background(Color("mainColor"))
        .ignoresSafeArea()
    }
}
