//
//  EventContentView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.05.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct EventContentView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @Binding var postModel: PostModel
    @Binding var userModel: UserModel
    
    @State var column = Array(repeating: GridItem(.flexible(), spacing: 1), count: 3)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {

            LazyVGrid(columns: column, spacing: 1) {
                ForEach(profileService.eventElements, id: \.id) {
                    (element) in
                    
                    if element.type == "IMAGE" {
                    WebImage(url: URL(string: element.uriOrUid))
                        .resizable()
                        .scaledToFill()
                        .frame(width: (UIScreen.main.bounds.width / 3) - 1, height: (UIScreen.main.bounds.width / 3) - 1)
                        .clipped()
                    }
                    
                    if element.type == "TEXT" {
                        Image(systemName: "gray")
                        .resizable()
                        .frame(width: element.type == "TEXT" ? UIScreen.main.bounds.width : 0, height: (UIScreen.main.bounds.width / 6) - 1)
                        
                            ColSpan2(span: element.type == "TEXT") {
                                ZStack {
                                Image(systemName: "gray")
                                .resizable()
                                .frame(width: element.type == "TEXT" ? UIScreen.main.bounds.width : 0, height: (UIScreen.main.bounds.width / 6) - 1)
                                    
                                    VStack {
                                        Text("Zitat:")
                                        Text(element.text)
                                    }
                                
                                    ColSpan2(span: true) {
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding(.top)
        .navigationTitle("")
        .navigationBarHidden(true)
        .onAppear {
            self.profileService.loadAllEventElements(postId: postModel.postId)
        }
    }
}

struct ColSpan<Content: View>: View {
    let span: Bool
    let content: () -> Content
    
    init(span: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.span = span
        self.content = content
    }
    
    var body: some View {
        content()
        
        if span { Color.clear }
    }
}

struct ColSpan2<Content: View>: View {
    let span: Bool
    let content: () -> Content
    
    init(span: Bool, @ViewBuilder content: @escaping () -> Content) {
        self.span = span
        self.content = content
    }
    
    var body: some View {
        content()
        
        if span { Color.clear }
    }
}
