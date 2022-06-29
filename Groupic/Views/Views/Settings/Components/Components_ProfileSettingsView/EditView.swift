//
//  EditView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 29.06.22.
//

import SwiftUI

struct EditView: View {
    @Binding var selectedProfile: Bool
    @Binding var cropImage: UIImage?
    @Binding var imageData: Data
    
    var body: some View {
        EmptyView()
        .fullScreenCover(isPresented: $selectedProfile) {
            ImageCrop(cropImage: $cropImage, showImageCrop: $selectedProfile)
        }
    }
}
