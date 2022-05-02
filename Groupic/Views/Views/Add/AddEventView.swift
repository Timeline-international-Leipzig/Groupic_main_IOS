//
//  AddView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 08.12.21.
//

import SwiftUI
import Photos
import RadioGroup

struct AddEventView: View {
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
                        .foregroundColor(Color("lightBlue"))
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top, 80)
                    
                    TextField("Titel", text: $caption)
                        .padding(.all, 5)
                        .multilineTextAlignment(.center)
                        .font(Font.system(size: 40, weight: .bold, design: .default))
                        .accentColor(.white)
                        .background(Color("background"))
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Image(systemName: "arrow.forward.square")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20))
                            
                            DatePicker("Startdatum", selection: $startDate, displayedComponents: .date).foregroundColor(.white)
                        }.padding(.horizontal, 20)
                        
                        HStack {
                            Image(systemName: "arrow.backward.square")
                                .foregroundColor(Color(.white))
                                .font(.system(size: 20))
                            
                            DatePicker("Enddatum", selection: $endDate, displayedComponents: .date).foregroundColor(.white)
                        }.padding(.horizontal, 20)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 60)
                    
                    Text("Wähle ein Titelbild aus")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(Color(.white))
                        .hCenter()
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
                            Image(systemName: "photo.circle")
                                .resizable()
                                .frame(width: 100, height: 100, alignment: .center)
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    self.showingActionsSheet = true
                                }
                                .padding(.top, 5)
                        }
                    }
                    .frame(alignment: .center)
                    
                    VStack {
                        Text("Wer darf das Ereignis anschauen?")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color(.white))
                        
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
                            label: {
                                Image(systemName: "multiply")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .bold))
                            }
                        )
                        .foregroundColor(.red)
                        .padding(.horizontal, 40)
                    
                        Button (
                            action: {self.uploadPost()
                                self.clear()
                            },
                            label: {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.white)
                                    .font(.system(size: 25, weight: .bold))
                            }
                        )
                        .foregroundColor(.green)
                        .padding(.horizontal, 40)
                    }
                    .padding(.top, 50)
                    .padding(.bottom, 60)
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
        .background(Color("background"))
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        }.ignoresSafeArea()
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
        PostService.uploadPost(caption: caption, startDate: startDate, endDate: endDate, index: selection, imageData: imageData, onSuccess: {
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

