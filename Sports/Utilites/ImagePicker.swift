//
//  ImagePicker.swift
//  Sports
//
//  Created by ios Dev on 02/07/2024.
//

import UIKit
import Photos

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var pickerController: UIImagePickerController?
    private var viewController: UIViewController?
    private var pickImageCallback: ((UIImage) -> Void)?
    
    override init() {
        super.init()
    }
    
    func pickImage(from source: UIImagePickerController.SourceType, _ viewController: UIViewController, _ callback: @escaping ((UIImage) -> Void)) {
        self.viewController = viewController
        self.pickImageCallback = callback
        
        if UIImagePickerController.isSourceTypeAvailable(source) {
            pickerController = UIImagePickerController()
            pickerController?.delegate = self
            pickerController?.sourceType = source
            pickerController?.allowsEditing = true
            viewController.present(pickerController!, animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "Warning", message: "Camera not available", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            viewController.present(alert, animated: true, completion: nil)
        }
    }
    
    func pickImageFromCamera(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> Void)) {
        pickImage(from: .camera, viewController, callback)
    }
    
    func pickImageFromGallery(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> Void)) {
        pickImage(from: .photoLibrary, viewController, callback)
    }
    
    func pickImage(_ viewController: UIViewController, _ callback: @escaping ((UIImage) -> Void)) {
        self.viewController = viewController
        self.pickImageCallback = callback
        
        let alert = UIAlertController(title: nil, message: "Choose Image", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                self.pickImageFromCamera(viewController, callback)
            }))
        }
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.pickImageFromGallery(viewController, callback)
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        viewController.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let editedImage = info[.editedImage] as? UIImage {
            self.pickImageCallback?(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            self.pickImageCallback?(originalImage)
        }
    }
}
