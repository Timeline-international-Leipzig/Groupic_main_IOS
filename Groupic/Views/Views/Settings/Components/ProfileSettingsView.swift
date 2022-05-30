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
    @State private var pickedImage: Image?
    @State private var pickedBackImage: Image?
    
    @State private var showingActionsSheet = false
    @State private var showingActionsBackSheet = false
    @State private var showingImagePicker = false
    @State private var showingImagePickerBackProfile = false
    @State private var changeProfileImage = false
    @State private var changeBackProfileImage = false
    
    @State var changeTextEmail = false
    @State var changeTextUsername = false
    @State var changeTextName = false
    
    @State var alert = false
    @State var alertEmailReauthentication = false
    @State var alertPasswordReauthentication = false
    
    
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
                VStack {
                    ProfileSettingsViewTabView(back: $back)
                }
                
                ScrollView {
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
                                
                                ProfilesettingsTextEditField(selectedIndex: 2, header: "", image: "", textField: "username", value: $username, change: $changeTextUsername)
                            }
                            
                            HStack(spacing: 83) {
                                Text("Name:")
                                
                                ProfilesettingsTextEditField(selectedIndex: 1, header: "", image: "", textField: "name", value: $name, change: $changeTextName)
                            }
                            
                            HStack(spacing: 80) {
                                Text("E-Mail:")
                                
                                ProfilesettingsTextEditField(selectedIndex: 0, header: "", image: "", textField: "email", value: $email, change: $changeTextEmail)
                            }
                            
                            HStack {
                                Button(action: {
                                    self.alertPasswordReauthentication.toggle()
                                }, label: {
                                    Text("Ändere dein Passwort")
                                        .background(Color.gray)
                                        .foregroundColor(.black)
                                })
                                .padding()
                                
                                Spacer()
                            }
                            .padding()
                            
                            
                            if Auth.auth().currentUser?.isEmailVerified == false {
                                HStack {
                                    Button(action: {
                                        Auth.auth().currentUser?.sendEmailVerification { error in
                                            self.error = "Es ist ein Fehler aufgetreten"
                                            self.alert.toggle()
                                        }
                                    }, label: {
                                        Text("Bestätige deine E-Mail")
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
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                        .background(
                            Color("AccentColor"))
                        .cornerRadius(10)
                        .padding(.bottom, 25)
                        .padding(.horizontal, 10)
                    }
                    else {
                        Button(action: {
                        }, label: {
                            Text("Bearbeiten")
                                .foregroundColor(.white)
                                .padding(.vertical)
                                .frame(width: UIScreen.main.bounds.width - 50)
                        })
                        .disabled(true)
                        .background(Color.gray)
                        .cornerRadius(10)
                        .padding(.bottom, 25)
                        .padding(.horizontal, 10)
                    }
                }
            }
            .background(Color.white)
            
            
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
    func checkIfUsernameOfAccountExists(completion: @escaping ((Bool) -> () )) {
        self.userCollection.whereField("userName", isEqualTo: self.username).getDocuments() {
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
        profileImage = inputImage
        changeProfileImage = true
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
