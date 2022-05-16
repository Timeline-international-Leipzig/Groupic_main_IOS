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
    @State var eventElements: [EventContentModel] = []
    
    var body: some View {
        HStack(spacing: 4) {
            if eventElements.count == 1 {
                if eventElements[0].type == "TEXT" {
                    HStack {
                        Text(eventElements[0].text)
                    }
                    .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
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
            
            /*
            if eventElements.count == 2 {
                if eventElements[0].type == "TEXT" && eventElements[1].type == "IMAGE" {
                    VStack {
                        HStack {
                            WebImage(url: URL(string: eventElements[1].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(eventElements[0].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    }
                }
                
                if eventElements[0].type == "IMAGE" && eventElements[1].type == "TEXT" {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text(eventElements[1].text)
                            
                            Spacer()
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
                
                if eventElements[0].type == "IMAGE" && eventElements[1].type == "IMAGE" {
                    WebImage(url: URL(string: eventElements[0].uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                    
                    WebImage(url: URL(string: eventElements[1].uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                
                    Spacer()
                }
            }
            
            if eventElements.count == 3 {
                if eventElements[0].type == "IMAGE" && eventElements[1].type == "TEXT" && eventElements[2].type == "IMAGE" {
                    VStack {
                        HStack {
                            WebImage(url: URL(string: eventElements[0].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                        
                        HStack {
                            Text(eventElements[1].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        
                        HStack {
                            WebImage(url: URL(string: eventElements[2].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                    }
                }
                
                if eventElements[0].type == "TEXT" && eventElements[1].type == "TEXT" && eventElements[2].type == "IMAGE" {
                    VStack {
                        HStack {
                            Text(eventElements[0].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        
                        HStack {
                            Text(eventElements[1].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        
                        HStack {
                            WebImage(url: URL(string: eventElements[2].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                    }
                }
                
                //---
                
                if eventElements[0].type == "IMAGE" && eventElements[1].type == "IMAGE" && eventElements[2].type == "TEXT" {
                    VStack {
                        HStack {
                            WebImage(url: URL(string: eventElements[0].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            WebImage(url: URL(string: eventElements[1].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text(eventElements[2].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    }
                }
                
                if eventElements[0].type == "TEXT" && eventElements[1].type == "IMAGE" && eventElements[2].type == "TEXT" {
                    VStack {
                        HStack {
                            Spacer()
                            
                            Text(eventElements[0].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        
                        HStack {
                            WebImage(url: URL(string: eventElements[1].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            
                            Text(eventElements[2].text)
                            
                            Spacer()
                        }
                        .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                    }
                }
                
                //---
                
                if eventElements[0].type == "IMAGE" && eventElements[1].type == "IMAGE" && eventElements[2].type == "IMAGE" {
                    WebImage(url: URL(string: eventElements[0].uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                    
                    WebImage(url: URL(string: eventElements[1].uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                    
                    WebImage(url: URL(string: eventElements[2].uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                }
                
                if eventElements[0].type == "TEXT" && eventElements[1].type == "IMAGE" && eventElements[2].type == "IMAGE" {
                    VStack {
                        HStack {
                            HStack {
                                Spacer()
                                
                                Text(eventElements[0].text)
                                
                                Spacer()
                            }
                            .frame(width: (UIScreen.main.bounds.width) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        }
                        
                        HStack {
                            WebImage(url: URL(string: eventElements[1].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            WebImage(url: URL(string: eventElements[2].uriOrUid))
                                .resizable()
                                .scaledToFill()
                                .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                                .clipped()
                            
                            Spacer()
                        }
                    }
                }
            }
            */
        }
    }
}
