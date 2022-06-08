//
//  LayoutImages.swift
//  Groupic
//
//  Created by Anatolij Travkin on 10.05.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct LayoutImages: View {
    @StateObject var profileService = ProfileService()
    @State var eventElements: [EventContentModel] = []
    @State var user: UserModel
    
    var body: some View {
        HStack(spacing: 4) {
            if eventElements.count == 1 {
                if eventElements[0].type == "TEXT" {
                    
                    HStack {
                        VStack {
                            if user.profileImageId == "" {
                                Image("profileImage")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .clipShape(Circle())
                            }
                            else {
                                WebImage(url: URL(string: user.profileImageId))
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 25, height: 25, alignment: .center)
                                    .clipShape(Circle())
                            }
                        }
                        
                        Text(user.username + ":")
                        
                        Text("\"" + eventElements[0].text + "\"")
                    }.padding()
                    
                    Spacer()
                }
                
                if eventElements[0].type == "IMAGE" {
                    WebImage(url: URL(string: eventElements[0].uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                    
                    Spacer()
                }
            }
            
            if eventElements.count == 2 && eventElements[0].type == "IMAGE" && eventElements[1].type == "IMAGE" {
                WebImage(url: URL(string: eventElements[1].uriOrUid))
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    .clipped()
                
                WebImage(url: URL(string: eventElements[0].uriOrUid))
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    .clipped()
                
                Spacer()
            }
            
            if eventElements.count == 2 && eventElements[0].type == "IMAGE" && eventElements[1].type == "TEXT" {
                VStack {
                    HStack {
                        
                        Text(user.username + ":")
                        
                        Text("\"" + eventElements[1].text + "\"")
                    }
                    .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    
                    HStack {
                        WebImage(url: URL(string: eventElements[0].uriOrUid))
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                            .clipped()
                        
                        Spacer()
                    }
                }
            }
            
            if eventElements.count == 3 && eventElements[0].type == "IMAGE" && eventElements[1].type == "IMAGE" && eventElements[2].type == "TEXT" {
                VStack {
                    HStack {
                        
                        Text(user.username + ":")
                                                
                        Text("\"" + eventElements[2].text + "\"")
                    }
                    .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    
                    HStack {
                        WebImage(url: URL(string: eventElements[1].uriOrUid))
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                            .clipped()
                        
                        WebImage(url: URL(string: eventElements[0].uriOrUid))
                            .resizable()
                            .scaledToFill()
                            .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                            .clipped()
                        
                        Spacer()
                    }
                }
            }
            
            if eventElements.count == 3 && eventElements[0].type == "IMAGE" && eventElements[1].type == "IMAGE" && eventElements[2].type == "IMAGE" {
                WebImage(url: URL(string: eventElements[2].uriOrUid))
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    .clipped()
                
                WebImage(url: URL(string: eventElements[1].uriOrUid))
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    .clipped()
                
                WebImage(url: URL(string: eventElements[0].uriOrUid))
                    .resizable()
                    .scaledToFill()
                    .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    .clipped()
            }
        }
    }
}
