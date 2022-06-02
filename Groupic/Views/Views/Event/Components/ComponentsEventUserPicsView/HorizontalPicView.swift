//
//  HorizontalPicView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 02.05.22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HorizontalPicView: View {
    @State var userModel: UserModel?
    @State private var next = false
    
       var body: some View {
           NavigationLink(destination: UserProfileView(user: $userModel, next: $next), isActive: self.$next, label: {
                EmptyView()
            })

            VStack {
                if userModel!.profileImageId == "" {
                    Button(action: {
                        self.next.toggle()
                    }, label: {
                        Image("profileImage")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    })
                }
                else {
                    Button(action: {
                        self.next.toggle()
                    }, label: {
                        WebImage(url: URL(string: userModel!.profileImageId))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 25, height: 25)
                            .clipShape(Circle())
                    })
                }
            }
    }
}
    

