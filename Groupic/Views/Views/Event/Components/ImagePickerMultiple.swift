//
//  EventContentView.swift
//  Groupic
//
//  Created by Anatolij Travkin on 03.05.22.
//

import SwiftUI
import PhotosUI
import Firebase

struct ImagePickerMultiple: UIViewControllerRepresentable {
    @Binding var postModel: PostModel
    @Binding var userModel: UserModel
    @State private var date = Date()
    
    @Binding var images: [UIImage]
    @Binding var picker: Bool
    
    func makeCoordinator() -> Coordinator {
        return ImagePickerMultiple.Coordinator(parentOne: self)
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0 
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: ImagePickerMultiple
        
        init(parentOne: ImagePickerMultiple) {
            parent = parentOne
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.picker.toggle()
                       
            for result in results {
                // Get all the images that you selected from the PHPickerViewController
                result.itemProvider.loadObject(ofClass: UIImage.self) { [self] object, error in
                // Check for errors
                if let error = error {
                    print("error \(error.localizedDescription)")
                } else {
                // Convert the image into Data so we can upload to firebase
                if let image = object as? UIImage {
                    let imageData = image.jpegData(compressionQuality: 0.5)
                                        
                    let eventId = PostService.allPosts.document(parent.postModel.postId).collection("events").document().documentID
                    let storagePostRef = StorageService.storagePostEventId(postId: parent.postModel.postId, eventId: eventId)
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/jpg"
                                        
                                        // You NEED to make sure you somehow change the name of each picture that you upload which is why I am using the variable "count".
                                        // If you do not change the filename for each picture you upload, it will try to upload the file to the same file and it will give you an error.
                    StorageService.saveEventPhoto(userId: parent.userModel.uid, username: parent.userModel.userName, stamp: parent.date, postId: parent.postModel.postId, eventId: eventId, imageData: imageData!, metadata: metadata, storagePostRef: storagePostRef, onSuccess: {}, onError: {errorMessage in })
                                        
                    print("Uploaded to firebase")
                    } else {
                    print("There was an error.")
                    }
                }
            }
        }
        }
    }
}
