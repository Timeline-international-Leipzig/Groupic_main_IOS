//
//  EventViewHeaderOrg.swift
//  Groupic
//
//  Created by Johannes Busch on 24.06.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventViewHeaderOrg: View {
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
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
    }
}
