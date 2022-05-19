//
//  ChangeEventModeView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 01.05.22.
//

import SwiftUI
import Firebase

struct ChangeEventModeView: View {
    
    @Binding var back: Bool
    
    @State var error = "Wer kann das Ereignis sehen?"
    @State var mode = ""
    
    @State var visible = false
    @State var nextView = false
    @State var alert = false
    
    @Binding var userModel: UserModel
    @Binding var postModel: PostModel
    
    var body: some View {
        GeometryReader{_ in
            HStack {
                Spacer()
                
                VStack {
                    Text(self.error)
                        .foregroundColor(Color.white)
                        .padding(.vertical)
                        .frame(alignment: .center)
                    
                    Menu {
                        Button {
                            //StorageService.editPostMode(userId: userModel.uid, postId: postModel.postId, index: 0, onSuccess: {})
                            self.mode = "Alle"
                        } label: {
                            Text("Alle")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                        }
                        Button {
                            //StorageService.editPostMode(userId: userModel.uid, postId: postModel.postId, index: 1, onSuccess: {})
                            self.mode = "Teilnehmer"
                        } label: {
                            Text("Teilnehmer")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                        }
                        Button {
                            //StorageService.editPostMode(userId: userModel.uid, postId: postModel.postId, index: 2, onSuccess: {})
                            self.mode = "Teilnehmer und Kontakte"
                        } label: {
                            Text("Teilnehmer und Kontakte")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                        }
                    } label: {
                        if mode != "" {
                            Text(mode)
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                                
                        }
                        else {
                            if postModel.index == 0 {
                            Text("Alle")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                            }
                            
                            if postModel.index == 1 {
                            Text("Teilnehmer")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                            }
                            
                            if postModel.index == 2 {
                            Text("Teilnehmer und Kontakte")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20, weight: .bold))
                        }
                        }
                    }
                    
                    Button(action: {
                        if mode == "Alle" {
                            StorageService.editPostMode(userId: userModel.uid, postId: postModel.postId, index: 0, onSuccess: {})
                            self.back.toggle()
                        }
                        
                        if mode == "Teilnehmer" {
                            StorageService.editPostMode(userId: userModel.uid, postId: postModel.postId, index: 1, onSuccess: {})
                            self.back.toggle()
                        }
                        
                        if mode == "Teilnehmer und Kontakte" {
                            StorageService.editPostMode(userId: userModel.uid, postId: postModel.postId, index: 2, onSuccess: {})
                            self.back.toggle()
                        }
                    }, label: {
                        Text("Modus ändern")
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
                .background(Color.black.opacity(0.85))
                .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                .frame(height: UIScreen.main.bounds.height - 50)
                
                Spacer()
            }
        }
        .background(Color.black.opacity(0.10).edgesIgnoringSafeArea(.all))
    }
}


