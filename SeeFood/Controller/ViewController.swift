//
//  ViewController.swift
//  SeeFood
//
//  Created by NazarStf on 28.05.2023.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

	@IBOutlet weak var imageView: UIImageView!
	
	let imagePicker = UIImagePickerController()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		imagePicker.delegate = self
		imagePicker.allowsEditing = true
	}
	
	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
		if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			imageView.image = userPickedImage
		}
		
		picker.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func galleryViewTapped(_ sender: UIBarButtonItem) {
		imagePicker.sourceType = .photoLibrary
		present(imagePicker, animated: true, completion: nil)
	}
	
	@IBAction func cameraViewTapped(_ sender: UIBarButtonItem) {
		imagePicker.sourceType = .camera
		present(imagePicker, animated: true, completion: nil)
	}
}

