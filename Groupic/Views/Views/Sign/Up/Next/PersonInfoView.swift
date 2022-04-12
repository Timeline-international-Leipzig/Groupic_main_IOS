//
//  PersonInfoView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 04/10/2021.
//

import SwiftUI
import Firebase

struct PersonInfoView: View {
    @StateObject private var formViewModel = FormViewModel()
    
    @State private var imageData: Data = Data()
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @State var color = Color.black
    
    @State var name = ""
    @State var username = ""
    
    @State var error = ""
    @State var errortitle = ""
    
    @State private var profileImage: Image?
    @State private var pickedImage: Image?
    
    @State private var showingActionsSheet = false
    @State private var showingImagePicker = false
    @State var visible = false
    @State var revisible = false
    @State var alert = false
    
    @Binding var next: Bool
    @Binding var viewState: Bool
    
    @Binding var email: String
    @Binding var password: String
    @Binding var repassword: String
    
    var body: some View {
            ZStack {
                ZStack (alignment: .topLeading) {
                    GeometryReader {_ in
                        VStack {
                            Text("Willkommen!")
                                .foregroundColor(Color("AccentColor"))
                                .font(.title)
                                .fontWeight(.bold)
                                .padding(.top, 25)
                            
                            VStack {
                                Group {
                                    if profileImage != nil {
                                        profileImage!.resizable()
                                            .clipShape(Circle())
                                            .frame(width: 150,
                                                   height: 150)
                                            .padding(.top, 20)
                                            .onTapGesture {
                                                self.showingActionsSheet = true
                                            }
                                    }
                                    else {
                                        Image(systemName: "person.circle.fill")
                                             .resizable()
                                            .clipShape(Circle())
                                            .frame(width: 100, height: 100)
                                            .padding(.top, 20)
                                            .onTapGesture {
                                                self.showingActionsSheet = true
                                            }
                                    }
                                }
                            }
                            
                            Group {
                                TextEditField(selectedIndex: 0, header: "Name", image: "mail", textField: "Dein persönlicher Name", value: $name)
                                
                                TextEditField(selectedIndex: 0, header: "Nutzername", image: "mail", textField: "Dein gewünschter Nutzername", value: $username)
                                
                                RegisterButton(name: $name, username: $username, email: $email, password: $password, profileImage: $profileImage, imageData: $imageData, error: $error, alert: $alert, viewState: $viewState)
                            }
                        }
                        .background(Color.white.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .circular))
                        .frame(height: UIScreen.main.bounds.height - 50)
                        .padding()
                    }
                    .background(
                        Image("login-b")
                            .resizable()
                            .scaledToFill()
                            .edgesIgnoringSafeArea(.all)
                    )
                }
                if self.alert {
                    ErrorView(alert: self.$alert, error: self.$error)
                }
            }
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
            .navigationBarHidden(true)
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
/// Functions
    func loadImage() {
        guard let inputImage = pickedImage else { return }
        profileImage = inputImage
    }
}
