//
//  ViewController.swift
//  MemeMe
//
//  Created by user on 18/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let textAttributes: [NSAttributedString.Key : Any]=[
        NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-CondensedBlack", size: 24) ,
        NSAttributedString.Key.foregroundColor:UIColor.white ,
        NSAttributedString.Key.strokeWidth:-5 ,
        NSAttributedString.Key.strokeColor:UIColor.black
       
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let isCameraAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
        if !isCameraAvailable {
            cameraButton.isEnabled = false
        }
        
        topLabel.defaultTextAttributes = textAttributes
        bottomLabel.defaultTextAttributes = textAttributes
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
     
        
        if let image = info[.originalImage]{
            print("image picker  controller")
            mainImageView.image = image as? UIImage
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
   
    

}

