//
//  EventViewHeader.swift
//  Groupic
//
//  Created by Anatolij Travkin on 28.04.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventViewHeader: View {
    @Binding var eventImage: Image?
    
    var post: PostModel?
    
    var body: some View {
            VStack {
                if eventImage != nil {
                    eventImage!
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: getRectView().width, height: 180, alignment: .center)
                        .cornerRadius(0)
                }
                else {
                    if post!.coverPic == "" {
                        Image("grey")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRectView().width, height: 180, alignment: .center)
                            .cornerRadius(0)
                    }
                    else {
                        WebImage(url: URL(string: post!.coverPic))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: getRectView().width, height: 180, alignment: .center)
                            .cornerRadius(0)
                    }
                }
            }
            .navigationBarTitle("")
    }
}


