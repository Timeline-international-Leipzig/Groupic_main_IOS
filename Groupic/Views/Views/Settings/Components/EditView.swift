//
//  EditView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 29.06.22.
//

import SwiftUI

struct EditView: View {
    @Binding var profileImageUI: UIImage?
    @Binding var selectedProfile: Bool
    @State var selectedProfileState = false
    @Binding var changeProfileImage: Bool
    @Binding var imageData: Data
    
    @State var backImage = false
    
    var body: some View {
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
                
                Button(action: {
                    loadImage()
                    self.selectedProfile.toggle()
                }, label: {
                    Text("Fertig")
                        .font(.custom("Inter-ExtraBold", size: 18))
                        .background(Color.gray)
                        .foregroundColor(.black)
                })
                
                Button(action: {
                    self.selectedProfile.toggle()
                }, label: {
                    Text("Abbrechen")
                        .font(.custom("Inter-ExtraBold", size: 18))
                        .background(Color.gray)
                        .foregroundColor(.black)
                })
            }
        }
        .navigationBarTitle("")
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

