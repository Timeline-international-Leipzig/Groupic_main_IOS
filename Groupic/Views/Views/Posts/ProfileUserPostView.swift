//
//  ProfileUserPostView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 19.03.22.
//
import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileUserPostView: View {
    @StateObject var profileService = ProfileService()
    
    var user: UserModel
    @State var currentPost: PostModel?
    
    @State var next = false
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(self.profileService.posts, id: \.dateN) {
                    (post) in
                    
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
                                    
                                    Text((Date(timeIntervalSince1970: post.dateN))
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
                        }
                       
                        VStack {
                            Button(
                                action: {
                                    self.currentPost = post
                                    
                                    next.toggle()
                                },
                                label: {
                                    WebImage(url: URL(string: post.mediaUrl)!)
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
                                        
                                        Text(post.startDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                            .offset(y: -10)
                                        
                                        Text(" - ")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                            .offset(y: -10)

                                        
                                        Text(post.endDate, style: .date)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .frame(alignment: .topLeading)
                                            .offset(y: -10)
                                    }
                                    
                                    HStack {
                                    Spacer()
                                    
                                    Text(post.caption)
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
            
            NavigationLink(destination: UserEventView(postModel: $currentPost, next: $next), isActive: self.$next, label: {
                EmptyView()
            })
                .isDetailLink(false)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.profileService.loadUserPosts(userId: user.uid)
        }
        

    }
}
