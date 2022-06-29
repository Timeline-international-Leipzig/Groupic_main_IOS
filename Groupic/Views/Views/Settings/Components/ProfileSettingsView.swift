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
    var userCollection = Firestore.firestore().collection("users")
    
    @EnvironmentObject var session: SessionStore
    
    @Binding var back: Bool
    
    @State private var name = ""
    @State private var username = ""
    @State private var email = ""
    
    @State private var rename = ""
    @State private var reusername = ""
    @State private var reemail = ""
    
    @State var errortitle = ""
    @State var error = ""
    
    @State private var imageData: Data = Data()
    @State private var backImageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State private var profileImage: Image?
    @State private var backProfileImage: Image?
    
    @State private var profileImageUI: UIImage?
    @State private var backProfileImageUI: UIImage?
    
    @State private var pickedImage: Image?
    @State private var pickedBackImage: Image?
    
    @State private var showingActionsSheet = false
    @State private var showingImagePicker = false
    @State private var showingImagePickerBackProfile = false
    @State private var changeProfileImage = false
    @State private var changeBackProfileImage = false
    
    @State var changeTextEmail = false
    @State var changeTextUsername = false
    @State var changeTextName = false
    @State var backImage = false
    @State var selectedProfile = false
    @State var selectedBackProfile = false
    
    @State var alert = false
    @State var alertEmailReauthentication = false
    @State var alertPasswordReauthentication = false
    
    
    init(session: UserModel?, back: Binding<Bool>) {
        _email = State(initialValue: session?.email ?? "")
        _username = State(initialValue: session?.username ?? "")
        _name = State(initialValue: session?.fullName ?? "")
        
        _back = back
    }
    
    var body: some View {
        
        ZStack {
            NavigationLink(destination: EditView(profileImageUI: $profileImageUI, selectedProfile: $selectedProfile, changeProfileImage: $changeProfileImage, imageData: $imageData), isActive: self.$selectedProfile, label: {
                EmptyView()
            })
            
            NavigationLink(destination: EditViewBack(profileImageUI: $backProfileImageUI, selectedProfile: $selectedBackProfile, changeProfileImage: $changeBackProfileImage, imageData: $backImageData), isActive: self.$selectedBackProfile, label: {
                EmptyView()
            })
            
            ProfileSettingsViewTabView(back: $back).zIndex(1)
            
            ScrollView {
                
                VStack(alignment: .center, spacing: 0) {
                    
                    ProfileSettingsViewProfileHeader(profileImage: $profileImage, profileImageUI: $profileImageUI, backProfileImage: $backProfileImage, backProfileImageUI: $backProfileImageUI, user: self.session.session!)
                    
                    VStack(spacing: 20) {
                        
                        Button(action: {
                            self.showingActionsSheet.toggle()
                        },
                               label: {
                            Label("Profilbild ändern", systemImage: "person")
                                .font(.custom("Inter-Regular", size: 18))
                                .foregroundColor(Color("buttonText"))
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        })
                        
                        Button(action: {
                            self.backImage = true
                            self.showingActionsSheet.toggle()
                        },
                               label: {
                            Label("Titelbild ändern", systemImage: "photo")
                                .font(.custom("Inter-Regular", size: 18))
                                .foregroundColor(Color("buttonText"))
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        })
                        
                        Button(action: {
                            self.alertPasswordReauthentication.toggle()
                        }, label: {
                            Label("Passwort ändern", systemImage: "lock")
                                .foregroundColor(Color("buttonText"))
                                .font(.custom("Inter-Regular", size: 18))
                                .padding(5)
                                .background(
                                    Color("buttonColor")
                                        .cornerRadius(5)
                                )
                        })
                    }.padding(.top, 30)
                    
                    
                    HStack {
                        VStack (alignment: .leading, spacing: -20) {
                            
                            HStack(spacing: 20) {
                                Text("Benutzername: ").font(.custom("Inter-Regular", size: 16))
                                
                                ProfilesettingsTextEditField(selectedIndex: 2, header: "", image: "", textField: "username", value: $username, change: $changeTextUsername)
                            }
                            
                            HStack(spacing: 83) {
                                Text("Name:").font(.custom("Inter-Regular", size: 16))
                                
                                ProfilesettingsTextEditField(selectedIndex: 1, header: "", image: "", textField: "fullName", value: $name, change: $changeTextName)
                            }
                            
                            HStack(spacing: 80) {
                                Text("E-Mail:").font(.custom("Inter-Regular", size: 16))
                                
                                ProfilesettingsTextEditField(selectedIndex: 0, header: "", image: "", textField: "email", value: $email, change: $changeTextEmail)
                            }
                            
                            if Auth.auth().currentUser?.isEmailVerified == false {
                                HStack {
                                    Button(action: {
                                        Auth.auth().currentUser?.sendEmailVerification { error in
                                            self.error = "Es ist ein Fehler aufgetreten"
                                            self.alert.toggle()
                                        }
                                    }, label: {
                                        Text("Bestätige deine E-Mail")
                                            .font(.custom("Inter-ExtraBold", size: 18))
                                            .background(Color.gray)
                                            .foregroundColor(.black)
                                    })
                                    .padding()
                                    
                                    Spacer()
                                }
                                .padding()
                            }
                        }
                        .padding()
                    }
                    
                    Spacer()
                    
                    if changeProfileImage == true || changeBackProfileImage == true || changeTextName == true || changeTextEmail == true ||
                        changeTextUsername == true {
                        
                        Button(action: {
                            if changeBackProfileImage == true {
                                self.editBackImage()
                                
                                if alert == false {
                                    self.error = "Dein Profile wurde bearbeitet"
                                    self.alert = true
                                }
                            }
                            
                            if changeProfileImage == true {
                                self.editProfileImage()
                                
                                if alert == false {
                                    self.error = "Dein Profile wurde bearbeitet"
                                    self.alert = true
                                }
                            }
                            
                            if changeTextEmail == true {
                                if isValidEmail(email) == false {
                                    self.error = "Keine valide E-Mail-Form"
                                    
                                    if alert == false {
                                        self.alert = true
                                    }
                                }
                                else {
                                    checkIfEmailOfAccountExists { result in
                                        if (result == true) {
                                            self.error = "Diese E-Mail existiert bereits! \n Wähle bitte eine neue E-Mail"
                                            if alert == false {
                                                self.alert = true
                                            }
                                        }
                                        
                                        else {
                                            if let error = errorCheck() {
                                                self.error = error
                                                if alert == false {
                                                    self.alert = true
                                                }
                                                
                                            }
                                            else {
                                                self.alertEmailReauthentication.toggle()
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            if changeTextUsername == true {
                                checkIfUsernameOfAccountExists { result in
                                    if (result == true) {
                                        self.error = "Diese Nutzername existiert bereits! \n Wähle bitte eine neue Nutzernamen"
                                        if alert == false {
                                            self.alert.toggle()
                                        }
                                    }
                                    
                                    else {
                                        self.editUsername()
                                        
                                        if alert == false {
                                            self.error = "Dein Profile wurde bearbeitet"
                                            self.alert = true
                                        }
                                    }
                                }
                            }
                            
                            if changeTextName == true {
                                self.editName()
                                
                                if alert == false {
                                    self.error = "Dein Profile wurde bearbeitet"
                                    self.alert = true
                                }
                            }
                            
                            Auth.auth().currentUser?.reload()
                            
                        }, label: {
                            Text("Bearbeiten")
                                .font(.custom("Inter-ExtraBold", size: 20))
                                .foregroundColor(Color("themeColor"))
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                        .background(Color("themeColor2"))
                        .cornerRadius(10)
                        .padding(.bottom, 200)
                        .padding(.horizontal, 10)
                    }
                    else {
                        Button(action: {
                        }, label: {
                            Text("Bearbeiten")
                                .font(.custom("Inter-ExtraBold", size: 20))
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                        .disabled(true)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.bottom, 200)
                        .padding(.horizontal, 10)
                    }
                }.padding(.top, 60)
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Rectangle().frame(width: getRectView().width, height: 100)
                }.background(Color(.black))
                    .mask(
                        LinearGradient(gradient: Gradient(colors: [Color.black, Color.black.opacity(0)]), startPoint: .bottom, endPoint: .top)
                    ).colorInvert()
            }
            
            if self.alert {
                ErrorView(alert: self.$alert, error: self.$error)
            }
            
            if self.alertEmailReauthentication {
                ReautheticationView(back: self.$alertEmailReauthentication, email: self.$email)
            }
            
            if self.alertPasswordReauthentication {
                ReautheticationPasswordView(back: self.$alertPasswordReauthentication)
            }
        }
        .background(Color("mainColor"))
        .ignoresSafeArea()
        .navigationBarTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .sheet(isPresented: $showingImagePickerBackProfile, onDismiss: loadBackProfileImage) {
            backImagePicker(pickedImage: self.$pickedBackImage, showImagePicker: self.$showingImagePickerBackProfile, imageData: self.$backImageData)
        }
        .actionSheet(isPresented: $showingActionsSheet) {
            ActionSheet(title: Text(""), buttons: [
                .default(Text("Wähle ein Bild")) {
                    if backImage == true {
                        self.sourceType = .photoLibrary
                        self.showingImagePickerBackProfile = true
                        self.backImage = false
                    }
                    else {
                        self.sourceType = .photoLibrary
                        self.showingImagePicker = true
                    }
                },
                .cancel()
            ])
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(pickedImage: self.$pickedImage, showImagePicker: self.$showingImagePicker, imageData: self.$imageData)
        }
        
        /*
        EmptyView()
        .fullScreenCover(isPresented: $selectedProfile,  onDismiss: loadImage) {
            ImageCrop(cropImage: $profileImageUI, showImageCrop: $selectedProfile, imageData: $imageData)
        }
        
        EmptyView()
        .fullScreenCover(isPresented: $selectedBackProfile,  onDismiss: loadImage) {
            ImageCrop(cropImage: $backProfileImageUI, showImageCrop: $selectedProfile, imageData: $imageData)
        }
         */
    }
    
    /// Functions:
    func checkIfUsernameOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("username", isEqualTo: self.username).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is already a user with this username")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
    
    func checkIfEmailOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("email", isEqualTo: self.email).getDocuments() {
            (QuerySnapshot, Error) in
            if let error = Error {
                print("Unable to query" + error.localizedDescription)
                completion(false)
            }
            else {
                if (QuerySnapshot!.count > 0) {
                    print("There is already a user with this email")
                    completion(true)
                }
                else {
                    print("There is no user")
                    completion(false)
                }
            }
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    /*
     func clear() {
     self.email = ""
     self.name = ""
     self.username = ""
     self.imageData = Data()
     self.backProfileImage = Image(systemName: "person.circle.fill")
     self.profileImage = Image(systemName: "person.circle")
     }
     */
    
    
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        profileImageUI = inputImage.asUIImage()
        profileImage = inputImage
        
        changeProfileImage = true
        
        if changeProfileImage == true {
            selectedProfile = true
        }
    }
    
    func loadBackProfileImage() {
        guard let inputImage = pickedBackImage else { return }
        backProfileImage = inputImage
        backProfileImageUI = inputImage.asUIImage()
        
        changeBackProfileImage = true
        
        if backProfileImage != nil {
            selectedBackProfile = true
        }
    }
    
    func errorCheck() -> String? {
        if  email.trimmingCharacters(in: .whitespaces).isEmpty ||
                name.trimmingCharacters(in: .whitespaces).isEmpty ||
                username.trimmingCharacters(in: .whitespaces).isEmpty {
            
            return "Fülle bitte alle Felder aus"
        }
        
        return nil
    }
    
    /*
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
     StorageService.editProfile(userId: userId, name: name, username: username, email: email, imageData: imageData, metaData: metaData,        storageProfileImageRef: storageProfileUserId) {
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
     StorageService.editBackProfile(userId: userId, name: name, username: username, email: email, imageData: backImageData, metaData: metaData,        storageProfileImageRef: storageProfileBackUserId) {
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
     
     StorageService.editProfile(userId: userId, name: name, username: username, email: email, imageData: imageData, metaData: metaData,        storageProfileImageRef: storageProfileUserId) {
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
     */
    
    func editProfileImage() {
        if let error = errorCheck() {
            self.error = error
            if alert == false {
                self.alert.toggle()
            }
        }
        
        guard let userId = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        let storageProfileUserId = StorageService.storageProfileId(userId: userId)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        StorageService.editProfile(userId: userId, name: name, username: username, email: email, imageData: imageData, metaData: metaData,        storageProfileImageRef: storageProfileUserId) {
        } onError: { errorMessage in
            self.error = errorMessage
            if alert == false {
                self.alert.toggle()
            }
            return
        }
    }
    
    func editBackImage() {
        if let error = errorCheck() {
            self.error = error
            if alert == false {
                self.alert.toggle()
            }
        }
        
        guard let userId = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        let storageProfileBackUserId = StorageService.storageBackProfileId(userId: userId)
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        StorageService.editBackProfile(userId: userId, name: name, username: username, email: email, imageData: backImageData, metaData: metaData, storageProfileImageRef: storageProfileBackUserId) {
        } onError: { errorMessage in
            self.error = errorMessage
            if alert == false {
                self.alert.toggle()
            }
            return
        }
    }
    
    func editUsername() {
        if let error = errorCheck() {
            self.error = error
            if alert == false {
                self.alert.toggle()
            }
        }
        
        guard let userId = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        StorageService.editProfileTextUsername(userId: userId, username: username, onSuccess: {})
    }
    
    func editName() {
        if let error = errorCheck() {
            self.error = error
            if alert == false {
                self.alert.toggle()
            }
        }
        
        guard let userId = Auth.auth().currentUser?.uid
        else {
            return
        }
        
        StorageService.editProfileTextName(userId: userId, name: name, onSuccess: {})
    }
}
