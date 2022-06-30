//
//  EventViewOrganizer.swift
//  Groupic
//
//  Created by Johannes Busch on 24.06.22.
//

import SwiftUI

struct EventViewOrganizer: View {
    
    @StateObject var profileService = ProfileService()
    @EnvironmentObject var session: SessionStore
    
    @State private var imageData: Data = Data()
    @State var imageDataMultiple : Data = .init(count: 0)
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var eventImage: Image?
    @State private var pickedImage: Image?
    @State var images: [UIImage] = []
    
    @State var isLoading = false
    
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
    @State var alertAdd = false
    @State var showparticipants = false
    
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
                        Rectangle().frame(width: getRectView().width, height: 100)
                    }.background(Color(.black))
                        .mask(
                            LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .top, endPoint: .bottom)
                        ).colorInvert()
                    
                    HStack {
                        
                        Spacer()
                        
                        Text(postModel.title)
                            .font(.system(size: 26, weight: .bold, design: .default))
                        
                        Spacer()
                    }.padding(.top, 30)
                    
                    HStack {
                        Button(action: {
                            self.next.toggle()
                        }, label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                        })
                        
                        Spacer()
                    }
                    .padding(.top, 30)
                    .padding(.leading, 20)
                    
                }
                
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
                
            }.zIndex(1)
            
            VStack(spacing:0) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    EventViewHeaderOrg(eventImage: $eventImage, post: postModel)
                    
                    /*PullToRefreshAnimationView(coordinateSpaceName: "pullToRefresh") {
                     // do your stuff when pulled
                     }*/
                    
                    VStack {
                        
                        ZStack {
                            
                            HStack {
                                
                                Spacer()
                                
                                DropDownMenu(showingActionsSheet: $showingActionsSheet, showingActionsSheetEventNameChange: $alertEventName, changeEventMode: $changeEventMode, deleteEvent: $deleteEvent).padding(.trailing, 20)
                            }
                            
                            HStack {
                                if  Calendar.current.component(.day, from: postModel.startDate) == Calendar.current.component(.day, from: postModel.endDate) {
                                    
                                    Spacer()
                                    
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                    
                                    Spacer()
                                }
                                
                                else {
                                    Text(postModel.startDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                    
                                    Text("-")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                    
                                    Text(postModel.endDate, style: .date)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                        .frame(alignment: .topLeading)
                                }
                            }
                        }
                        
                        Button(action: {}, label: {
                            Label("Kostenpflichtig beitreten", systemImage: "ticket")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("buttonText"))
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        }).padding()
                        
                        Button(action: {}, label: {
                            Label("Ticket", systemImage: "ticket.fill")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color("buttonText"))
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        }).padding()
                    }
                }
            }
            
            if self.alertEventName {
                EventNameView(back: $alertEventName, userModel: $userModel, postModel: $postModel, eventName: $eventName)
            }
            
            if self.alertAdd {
                AddContactsView(back: $alertAdd, post: $postModel)
            }
            
            if self.showparticipants {
                ParticipantsView(back: $showparticipants, post: $postModel)
            }
            
            if self.changeEventMode {
                ChangeEventModeView(back: $changeEventMode, userModel: $userModel, postModel: $postModel)
            }
            
            if self.deleteEvent {
                LeaveEventView(back: $deleteEvent, backCompleteDelete: $next, userModel: $userModel, postModel: $postModel)
            }
            
            if self.textQuote {
                EventQuoteView(back: $textQuote, userModel: $userModel, postModel: $postModel, quote: $quote, isLoading: $isLoading)
            }
        }
        .background(Color("mainColor"))
        .ignoresSafeArea()
    }
}
