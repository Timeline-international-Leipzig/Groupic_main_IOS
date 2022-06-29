//
//  ImageCrop.swift
//  Groupic
//
//  Created by Anatolij Travkin on 28.06.22.
//

import Mantis
import Foundation
import SwiftUI

struct ImageCropBack: UIViewControllerRepresentable {
     typealias Coordinator = ImageCropCoordinatorBack
    
    @Binding var cropImage: UIImage?
    @Binding var showImageCrop: Bool
    @Binding var imageData: Data
    
    func makeCoordinator() -> ImageCropCoordinator {
        return ImageCropCoordinatorBack(self)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImageCropBack>) -> Mantis.CropViewController {
        var config = Mantis.Config()
        config.presetFixedRatioType = .canUseMultiplePresetFixedRatio(defaultRatio: 1.0 / 1.0)
        
        let cropper = Mantis.cropViewController(image: (cropImage)!, config: config)
        cropper.delegate = context.coordinator
        return cropper
    }
}

class ImageCropCoordinatorBack: NSObject, CropViewControllerDelegate {
    var parent: ImageCropBack
    
    init(_ parent: ImageCropBack) {
        self.parent = parent
    }
    
    func cropViewControllerDidCrop(_ cropViewController: CropViewController, cropped: UIImage, transformation: Transformation, cropInfo: CropInfo) {
        parent.cropImage = cropped
        
        if let mediaData =  parent.cropImage!.jpegData(compressionQuality: 0.5) {
            parent.imageData = mediaData
        }
        
        parent.showImageCrop.toggle()
    }

    func cropViewControllerDidFailToCrop(_ cropViewController: CropViewController, original: UIImage) {
        
    }

    func cropViewControllerDidCancel(_ cropViewController: CropViewController, original: UIImage) {
        parent.showImageCrop.toggle()
    }

    func cropViewControllerDidBeginResize(_ cropViewController: CropViewController) {
        
    }

    func cropViewControllerDidEndResize(_ cropViewController: CropViewController, original: UIImage, cropInfo: CropInfo) {
        
    }

}


