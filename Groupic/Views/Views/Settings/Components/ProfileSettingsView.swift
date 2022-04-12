//
//  ProfileSettingsView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 29.03.22.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct ProfileSettingsView: View {
    @EnvironmentObject var session: SessionStore
    
    @Binding var back: Bool
    
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    
    @State var errortitle = ""
    @State var error = ""
    
    @State private var imageData: Data = Data()
    @State private var backImageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var profileImage: Image?
    @State private var backProfileImage: Image?
    @State private var pickedImage: Image?
    @State private var pickedBackImage: Image?
    
    @State private var showingActionsSheet = false
    @State private var showingActionsBackSheet = false
    @State private var showingImagePicker = false
    @State private var showingImagePickerBackProfile = false
    @State private var changeprofileImage = false
    @State private var changeBackProfileImage = false
    
    @State var alert = false
    
    init(session: UserModel?, back: Binding<Bool>) {
        _email = State(initialValue: session?.email ?? "")
        _username = State(initialValue: session?.userName ?? "")
        _name = State(initialValue: session?.name ?? "")
        
        _back = back
    }
    
    var body: some View {
        ZStack {
            Color("AccentColor").ignoresSafeArea(.all, edges: .top)
            
            VStack(alignment: .center, spacing: 0) {
                
                ProfileSettingsViewProfileHeader(profileImage: $profileImage, backProfileImage: $backProfileImage, user: self.session.session!)
                
                HStack {
                    VStack(spacing: 10) {
                        Button(action: {
                            self.showingActionsSheet.toggle()
                        },
                            label: {
                            Text("Profilbild ändern")
                                .foregroundColor(Color("AccentColor"))
                        })
                        .cornerRadius(20)
                        .padding(.horizontal)
                        
                        Button(action: {
                            self.showingImagePickerBackProfile.toggle()
                        },
                            label: {
                                Text("Titelbild ändern")
                                .foregroundColor(Color("AccentColor"))
                        })
                        .cornerRadius(20)
                        .padding(.horizontal)
                    }
                }
                .padding(40)
                
                HStack {
                    VStack (alignment: .leading, spacing: 10) {
                        
                        HStack(spacing: 20) {
                            Text("Benutzername:")
                            
                            EditTextField(textField: "username", value: $username)
                        }
                        
                        HStack(spacing: 83) {
                            Text("Name:")
                            
                            EditTextField(textField: "name", value: $name)
                        }
                        
                        HStack(spacing: 80) {
                            Text("E-Mail:")
                            
                            EditTextField(textField: "email", value: $email)
                        }
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    self.edit()
                }, label: {
                    Text("Bearbeiten")
                        .foregroundColor(.white)
                        .padding(.vertical)
                        .frame(width: UIScreen.main.bounds.width - 50)
                })
                .background(Color("AccentColor"))
                .cornerRadius(10)
                .padding(.bottom, 25)
                .padding(.horizontal, 10)
            }
            .background(Color.white)
            
            VStack {
                ProfileSettingsViewTabView(back: $back)
            
                Spacer()
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
        }
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .sheet(isPresented: $showingImagePickerBackProfile, onDismiss: loadBackProfileImage) {
            backImagePicker(pickedImage: self.$pickedBackImage, showImagePicker: self.$showingImagePickerBackProfile, imageData: self.$backImageData)
        }
        .actionSheet(isPresented: $showingActionsBackSheet) {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Wähle ein Bild")){
                    self.sourceType = .photoLibrary
                    self.showingImagePickerBackProfile = true
                },
                .default(Text("Mach ein Bild")){
                    self.sourceType = .camera
                    self.showingImagePickerBackProfile = true
                },
                .cancel()
            ])
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
    
    /// Functions:
    func clear() {
        self.email = ""
        self.name = ""
        self.username = ""
        self.imageData = Data()
        self.backProfileImage = Image(systemName: "person.circle.fill")
        self.profileImage = Image(systemName: "person.circle")
    }
    
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        profileImage = inputImage
        changeprofileImage = true
    }
    
    func loadBackProfileImage() {
        guard let inputImage = pickedBackImage else { return }
        backProfileImage = inputImage
        changeBackProfileImage = true
    }
    
    func errorCheck() -> String? {
        if  email.trimmingCharacters(in: .whitespaces).isEmpty ||
            name.trimmingCharacters(in: .whitespaces).isEmpty ||
            username.trimmingCharacters(in: .whitespaces).isEmpty {

            return "Fülle bitte alle Felder aus"
        }
        
        return nil
    }
    
    func edit() {
        if let error = errorCheck() {
            self.error = error
            self.alert.toggle()
            self.clear()
            return
        }
        
        guard let userId = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        let storageProfileUserId = StorageService.storageProfileId(userId: userId)
        let storageProfileBackUserId = StorageService.storageBackProfileId(userId: userId)
        let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
        
        if changeprofileImage == true {
        StorageService.editProfile(userId: userId, name: name, username: username, email: email, imageData: imageData, metaData: metaData, storageProfileImageRef: storageProfileUserId) {
            self.clear()
        } onError: { errorMessage in
            self.error = errorMessage
            self.alert.toggle()
            return
        }
        }
        else {
            StorageService.editProfileText(userId: userId, name: name, username: username, email: email) {}
        }
        
        if changeBackProfileImage == true {
        StorageService.editBackProfile(userId: userId, name: name, username: username, email: email, imageData: backImageData, metaData: metaData, storageProfileImageRef: storageProfileBackUserId) {
            self.clear()
        } onError: { errorMessage in
            self.error = errorMessage
            self.alert.toggle()
            return
        }
        }
        else {
            StorageService.editProfileText(userId: userId, name: name, username: username, email: email) {}
        }
        
        if changeBackProfileImage && changeprofileImage == true {
        StorageService.editBackProfile(userId: userId, name: name, username: username, email: email, imageData: backImageData, metaData: metaData, storageProfileImageRef: storageProfileBackUserId) {
            
            StorageService.editProfile(userId: userId, name: name, username: username, email: email, imageData: imageData, metaData: metaData, storageProfileImageRef: storageProfileUserId) {
                self.clear()
            } onError: { errorMessage in
                self.error = errorMessage
                self.alert.toggle()
                return
            }
        } onError: { errorMessage in
            self.error = errorMessage
            self.alert.toggle()
            return
        }
        }
        else {
            StorageService.editProfileText(userId: userId, name: name, username: username, email: email) {}
        }
    }
}

