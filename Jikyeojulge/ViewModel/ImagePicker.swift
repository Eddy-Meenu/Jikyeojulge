//
//  ImagePicker.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/06/28.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var images: UIImage?
    @Binding var show: Bool

    @Environment(\.presentationMode) private var presentationMode
    var sourceType: UIImagePickerController.SourceType = .photoLibrary

    private var url: URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0].appendingPathComponent("image.jpg")
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator

        return imagePicker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let img0: ImagePicker
        init(img1: ImagePicker) {
            img0 = img1
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.img0.show.toggle()
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            guard let image = info[.originalImage] as? UIImage else { return }

                self.img0.images = image
                self.img0.show.toggle()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        return Self.Coordinator(img1: self)
    }
}
