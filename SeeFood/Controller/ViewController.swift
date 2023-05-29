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
			
			guard let ciimage = CIImage(image: userPickedImage) else {
				fatalError("Couldn't convert to CIImage")
			}
			
			detect(image: ciimage)
		}
		
		picker.dismiss(animated: true, completion: nil)
	}
	
	func detect(image: CIImage) {
		guard let model = try? VNCoreMLModel(for: MLModel(contentsOf: Inceptionv3.urlOfModelInThisBundle)) else {
			fatalError("Loading CoreML Model failed")
		}
		
		let request = VNCoreMLRequest(model: model) { request, error in
			guard let results = request.results as? [VNClassificationObservation] else {
				fatalError("Model failed to process image")
			}
			
			if let firstResult = results.first {
				if firstResult.identifier.contains("hotdog") {
					self.navigationController?.title = "Hotdog"
				} else {
					self.navigationController?.title = "Not Hotdog"
				}
			}
		}
		
		let handler = VNImageRequestHandler(ciImage: image)
		
		do {
			try handler.perform([request])
		}
		catch {
			print(error)
		}
		
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

