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
                    HStack(spacing: 0) {
                        WebImage(url: URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 60, height: 60, alignment: .trailing)
                            //.padding()
                        
                        Text("\"" + eventElements[0].text + "\"")
                        
                        Text(" - " + user.userName)
                        
                        Spacer()
                    }.padding(.leading, 5)
                    //.frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
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
                        Text(eventElements[1].text)
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
                        Text(eventElements[2].text)
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
