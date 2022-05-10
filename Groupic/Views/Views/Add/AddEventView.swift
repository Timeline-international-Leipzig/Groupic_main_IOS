//
//  AddView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 08.12.21.
//

import SwiftUI
import Photos
import RadioGroup
import Firebase

struct AddEventView: View {
    @State var user: UserModel
    
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State var selection: Int = 0
    
    @State var error = ""
    @State var errortitle = ""
    @State var caption = ""
    
    @State private var eventImage: Image?
    @State private var eventImages: Image?
    @State private var pickedImage: Image?
    
    @State private var showingActionsSheet = false
    @State private var showingImagePicker = false
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    
    @Binding var shouldShowModel: Bool
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
        VStack {
            ZStack {
                VStack {
                    Text("Erstelle ein Ereignis")
                        .foregroundColor(Color("AccentColor"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 20)
                    
                    TextField("Titel", text: $caption)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .font(Font.system(size: 40, weight: .bold, design: .default))
                                    .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "arrow.forward.square")
                                .foregroundColor(Color("darkBlue"))
                                .font(.system(size: 20))
                            
                            DatePicker("Startdatum", selection: $startDate, displayedComponents: .date)
                        }.padding(.horizontal, 20)
                        
                        HStack {
                            Image(systemName: "arrow.backward.square")
                                .foregroundColor(Color("darkBlue"))
                                .font(.system(size: 20))
                            
                            DatePicker("Enddatum", selection: $endDate, displayedComponents: .date)
                        }.padding(.horizontal, 20)
                    }
                    .padding(.top, 10)
                    
                    Text("Wähle ein Titelbild aus:")
                        .fontWeight(.bold)
                        .foregroundColor(Color("AccentColor"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .padding(.top, 10)
                    
                    
                    VStack {
                        if eventImage != nil {
                            eventImage!.resizable()
                                .clipShape(Circle())
                                .frame(width: 100, height: 100, alignment: .center)
                                .onTapGesture {
                                    self.showingActionsSheet = true
                                }
                        } else {
                            Image(systemName: "photo.circle").resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .onTapGesture {
                                    self.showingActionsSheet = true
                                }
                                .padding(.top, 5)
                        }
                    }
                    .frame(alignment: .center)
                    
                    VStack {
                        Text("Wer darf das Ereignis anschauen?")
                            .foregroundColor(Color("AccentColor"))
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                        RadioGroupPicker(
                            selectedIndex: $selection,
                            titles: ["Jeder", "Teilnehmer", "Teilnehmer und deren Kontakte"])
                                .spacing(20)
                        }
                        .padding(.horizontal, 60)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                     
                    HStack {
                        Button (
                            action: {shouldShowModel.toggle()},
                            label: {Text("Abbrechen")
                                    .foregroundColor(.red)
                            }
                        )
                        .foregroundColor(.red)
                        .padding()
                    
                        Button (
                            action: {self.uploadPost()
                                self.clear()
                            },
                            label: {Text("Bestätigen")
                                    .foregroundColor(Color("AccentColor"))
                            }
                        )
                        .foregroundColor(.green)
                        .padding()
                    }
                    .padding(.top, 30)
                }
                
                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error)
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
            }
            .actionSheet(isPresented: $showingActionsSheet) {
                ActionSheet(title: Text(""), buttons: [
                    .default(Text("Wähle ein Bild")){
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    },
                    .default(Text("Mach ein Bild")){
                        self.sourceType = .camera
                        self.showingImagePicker = true
                    },
                    .cancel()
                ])
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        }
    }
    
/// Functions
    func errorCheck() -> String? {
        if  caption.trimmingCharacters(in: .whitespaces).isEmpty ||
            imageData.isEmpty {
            return "Fülle bitte alle Felder aus"
        }
        return nil
    }
    
    func uploadPost() {
        if let error = errorCheck() {
            self.error = error
            self.alert.toggle()
            self.clear()
            return
        }
        //firebase
        
        Auth.auth().currentUser?.reload()
        PostService.uploadPost(caption: caption, username: user.userName, startDate: startDate, endDate: endDate, index: selection, imageData: imageData, onSuccess: {
            
            self.shouldShowModel.toggle()
        }) {
            (errorMessage) in
            self.error = errorMessage
            self.alert.toggle()
            return
        }
    }
    
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        eventImage = inputImage
    }
    
    func clear() {
        self.caption = ""
        self.imageData = Data()
        self.startDate = Date()
        self.endDate = Date()
        self.eventImage = Image(systemName: "photo.circle")
    }
}

