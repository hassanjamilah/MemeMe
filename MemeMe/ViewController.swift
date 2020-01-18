//
//  ViewController.swift
//  MemeMe
//
//  Created by user on 18/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UIPageViewControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        if !isCameraAvailable {
            cameraButton.isEnabled = false
        }
        
    }
    
    @IBAction func shareImage(_ sender: Any) {
    }
    
    @IBAction func saveImage(_ sender: Any) {
    }
    
    
    @IBAction func getImageViaCamera(){
        showImagePickerContoller(isCamera: true)
    }
    
    @IBAction func getImageViaGallery(){
        showImagePickerContoller(isCamera: false)
    }

    
    func showImagePickerContoller(isCamera:Bool){
        let contoller = UIImagePickerController()
        contoller.delegate  = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if isCamera {
            contoller.sourceType = .camera
        }
        present(contoller, animated: true, completion: nil)
        
    }

}

