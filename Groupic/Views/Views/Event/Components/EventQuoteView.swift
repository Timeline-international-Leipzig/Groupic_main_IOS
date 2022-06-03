//
//  EventQuoteView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 05.05.22.
//

import SwiftUI
import Firebase

struct EventQuoteView: View {
    @State var color = Color.black.opacity(0.7)
    
    @Binding var back: Bool
    
    @State var error = "Gebe das Zitat ein"
    
    @State var closetitle = "Schließen"
    
    @State var visible = false
    @State var nextView = false
    @State var alert = false
    
    @Binding var userModel: UserModel
    @Binding var postModel: PostModel
    @Binding var quote: String
    
    @State private var date = Date()
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    TextEditFieldBlack(selectedIndex: 1, header: "", image: "", textField: "", value: $quote)
                    
                    Button(action: {
                        eventQuote()
                        self.back.toggle()
                    }, label: {
                        Text("Zitat speichern")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                    .padding(.top, 25)
                    
                    Button(action: {
                        self.back.toggle()
                    }, label: {
                        Text("Schließen")
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 120)
                    })
                    .background(Color("AccentColor"))
                    .cornerRadius(10)
                }
                .padding(.all, 25)
                .frame(width: UIScreen.main.bounds.width - 90)
                .background(Color.white.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
    
    ///Functions
    func eventQuote() {
        if let error = errorCheck() {
            self.error = error
            if alert == false {
                self.alert.toggle()
            }
        }
        
        let eventId = PostService.allPosts.document(postModel.id).collection("events").document().documentID
        
        StorageService.saveEventQuote(userId: userModel.uid, text: quote, username: userModel.username, userPicture: userModel.profileImageId, stamp: date, postId: postModel.id, eventId: eventId, onSuccess: {}, onError: {errorMessage in })
    }
    
    func errorCheck() -> String? {
        if  quote.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "Fülle das Feld aus"
        }
        
        return nil
    }
}




