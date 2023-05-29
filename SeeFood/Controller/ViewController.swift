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
		imagePicker.sourceType = .camera
		imagePicker.allowsEditing = true
		
	}

	func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		
		if let userPicketImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
			imageView.image = userPicketImage
		}
		
		imagePicker.dismiss(animated: true, completion: nil)
	}
	
	@IBAction func cameraTapped(_ sender: UIBarButtonItem) {
		
		present(imagePicker, animated: true, completion: nil)
		
	}
	
}

