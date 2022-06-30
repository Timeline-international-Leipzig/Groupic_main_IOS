//
//  EditView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 29.06.22.
//

import SwiftUI

struct EditView: View {
    @EnvironmentObject var session: SessionStore
    
    @Binding var profileImageUI: UIImage?
    @Binding var selectedProfile: Bool
    @State var selectedProfileState = false
    @State var profile = false
    @Binding var changeProfileImage: Bool
    @Binding var imageData: Data
    
    @State var backImage = false
    
    var body: some View {
        NavigationLink(destination: ProfileSettingsView(session: self.session.session, back: $profile), isActive: self.$profile, label: {
            EmptyView()
        })
        
        ZStack{
            VStack {
                Text("Preview:")
                
                Image(uiImage: profileImageUI!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: getRectView().width - 10, height: getRectView().width - 10, alignment: .center)
                    .clipShape(Circle())
                
                Button(action: {
                    self.selectedProfileState.toggle()
                }, label: {
                    Text("Edit")
                        .font(.custom("Inter-ExtraBold", size: 18))
                        .background(Color.gray)
                        .foregroundColor(.black)
                })
            }
        }
        .navigationBarTitle("")
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
             Text("Fertig")
            }
        }
        .fullScreenCover(isPresented: $selectedProfileState,  onDismiss: loadImage) {
            ImageCrop(cropImage: $profileImageUI, showImageCrop: $selectedProfileState, back: $backImage, imageData: $imageData)
        }
    }
    
    func loadImage() {
        guard let inputImage = profileImageUI else { return }
        profileImageUI = inputImage
        
        changeProfileImage = true
    }
}

