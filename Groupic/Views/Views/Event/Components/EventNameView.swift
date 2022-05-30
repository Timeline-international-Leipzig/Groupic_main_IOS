//
//  EventNameView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 30.04.22.
//

import SwiftUI
import Firebase

struct EventNameView: View {
    @State var color = Color.black.opacity(0.7)
    
    @Binding var back: Bool
    
    @State var error = "Gebe dein Titel ein:"
    
    @State var closetitle = "Schließen"
    
    @State var visible = false
    @State var nextView = false
    @State var alert = false
    
    @Binding var userModel: UserModel
    @Binding var postModel: PostModel
    @Binding var eventName: String
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(self.color)
                        .padding(.top)
                        .padding(.horizontal, 25)
                    
                    TextEditFieldBlack(selectedIndex: 1, header: "", image: "", textField: "", value: $eventName)
                    
                    Button(action: {
                        editEventName()
                        self.back.toggle()
                    }, label: {
                        Text("Titel ändern")
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
    func editEventName() {
        if let error = errorCheck() {
            self.error = error
            if alert == false {
                self.alert.toggle()
            }
        }
        
        StorageService.editPostTextTitle(userId: userModel.uid, postId: postModel.postId, caption: eventName, onSuccess: {})
    }
    
    func errorCheck() -> String? {
        if  eventName.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "Fülle das Feld aus"
        }
        
        return nil
    }
}

