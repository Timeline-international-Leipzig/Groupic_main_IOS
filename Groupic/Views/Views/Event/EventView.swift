//
//  EventView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04.01.22.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase

struct EventView: View {
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @State private var imageData: Data = Data()
    @State var imageDataMultiple : Data = .init(count: 0)
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var eventImage: Image?
    @State private var pickedImage: Image?
    @State var images: [UIImage] = []
    
    @State private var showingActionsSheet = false
    @State private var showingActionsSheetCamera = false
    @State private var showingImagePickerCamera = false
    @State private var showingImagePicker = false
    
    @State private var changeProfileImage = false
    
    @State var changeTextName = false
    @State var alertEventName = false
    @State var nextChangeEventName = false
    @State var changeEventMode = false
    @State var deleteEvent = false
    @State var picker = false
    @State var textQuote = false
    
    @State var eventName = ""
    @State var quote = ""
    
    @Binding var postModel: PostModel
    @Binding var userModel: UserModel
    @Binding var next: Bool
    
    var body: some View {
        ZStack {
            
            VStack {
                
                ZStack {
                    
                    HStack {
                        
                        Button(action: {
                            self.next.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        .padding()
                        
                        Spacer()
                        
                    }.zIndex(1)
                                        
                    HStack {
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        ).colorInvert()
                }
                
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
            }.zIndex(1)
            
            VStack {
                
                ScrollView(.vertical, showsIndicators: false) {
                    PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                        // do your stuff when pulled
                    }
                    
                    VStack {
                        EventViewHeader(eventImage: $eventImage, post: postModel)
                        
                        ZStack {
                            
                            Text(postModel.caption)
                                .font(.system(size: 26, weight: .bold, design: .default))
                                .foregroundColor(.white)
                            
                            HStack {
                                
                                Spacer()
                                
                                DropDownMenu(showingActionsSheet: $showingActionsSheet, showingActionsSheetEventNameChange: $alertEventName, changeEventMode: $changeEventMode, deleteEvent: $deleteEvent)
                                
                            }.padding(.horizontal)
                        }
                        
                        HStack {
                            Text(postModel.startDate, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            
                            Text(" - ")
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            
                            Text(postModel.endDate, style: .date)
                                .font(.subheadline)
                                .foregroundColor(.white)
                                .frame(alignment: .topLeading)
                            
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        
                        FollowEventButton(post: postModel, followCheck: $profileService.followCheck)
                        
                        Text("Mit:")
                            .foregroundColor(.white)
                            .padding(10)
                        
                        ZStack {
                            EventUserPicsView(post: $postModel)

                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "person.crop.circle.badge.plus")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20))
                                })
                            }
                            .padding(.horizontal)
                        }
                        
                        HStack {
                            Spacer()
                            
                            Button(action: {
                                self.picker.toggle()
                            }, label: {
                                Image(systemName: "photo.fill.on.rectangle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            })
                            
                            /*
                            Button(action: {
                                self.showingActionsSheetCamera.toggle()
                            }, label: {
                                Image(systemName: "camera.fill")
                                    .foregroundColor(.black)
                                    .font(.system(size: 20))
                            })
                            */
                             
                            Button(action: {
                                self.textQuote.toggle()
                            }, label: {
                                Image(systemName: "text.bubble")
                                    .foregroundColor(.white)
                                    .font(.system(size: 20))
                            })
                            
                            Spacer()
                        }
                        .padding(.top)
                        
                        EventContentView(postModel: $postModel, userModel: $userModel)
                    }
                }.offset(y: -17)
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
            
            if self.alertEventName {
                EventNameView(back: $alertEventName, userModel: $userModel, postModel: $postModel, eventName: $eventName)
            }
            
            if self.changeEventMode {
                ChangeEventModeView(back: $changeEventMode, userModel: $userModel, postModel: $postModel)
            }
            
            if self.deleteEvent {
                DeleteEventView(back: $deleteEvent, backCompleteDelete: $next, userModel: $userModel, postModel: $postModel)
            }
            
            if self.textQuote {
                EventQuoteView(back: $textQuote, userModel: $userModel, postModel: $postModel, quote: $quote)
            }
        }
        .background(Color("background"))
        .ignoresSafeArea()
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }
        .actionSheet(isPresented: $showingActionsSheet) {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Wähle ein Bild")) {
                    self.sourceType = .photoLibrary
                    self.showingImagePicker = true
                },
                .default(Text("Mach ein Bild")) {
                    self.sourceType = .camera
                    self.showingImagePicker = true
                },
                .cancel()
            ])
        }
        
        /*
        .sheet(isPresented: $showingImagePickerCamera, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }
        .actionSheet(isPresented: $showingActionsSheetCamera) {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Mach ein Bild")){
                    self.sourceType = .camera
                    self.showingImagePicker = true
                },
                .cancel()
            ])
        }
        */
        
        .sheet(isPresented: $picker) {
            ImagePickerMultiple(postModel: $postModel, userModel: $userModel, images: self.$images, picker: $picker)
        }
    }
    
    /// Functions
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        eventImage = inputImage
        changeProfileImage = true
        
        self.editProfileImage()
    }
    
    
    
    func editProfileImage() {
        let storagePostId = StorageService.storagePostId(postId: postModel.postId)
        let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
        
        StorageService.editPost(postId: postModel.postId, userId: userModel.uid, imageData: imageData, metaData: metaData, storagePostRef: storagePostId, onSuccess: {}, onError: {errorMessage in })
    }
}

