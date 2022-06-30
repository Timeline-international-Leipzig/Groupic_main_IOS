//
//  EditView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 29.06.22.
//

import SwiftUI

struct EditViewBack: View {
    @Binding var profileImageUI: UIImage?
    @Binding var selectedProfile: Bool
    @State var selectedProfileState = false
    @Binding var changeProfileImage: Bool
    @Binding var imageData: Data
    @State var backImage = true
    
    var body: some View {
        ZStack{
            VStack {
                Text("Preview:")
                Image(uiImage: profileImageUI!)
                    .resizable()
                    .frame(width: getRectView().width, height: 180, alignment: .center)
                
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

