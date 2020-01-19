//
//  ViewController.swift
//  MemeMe
//
//  Created by user on 18/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class ViewController: UIViewController  , UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var topLabel: UITextField!
    @IBOutlet weak var bottomLabel: UITextField!
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var toolBar: UIToolbar!
    
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var tap:UITapGestureRecognizer!
    var isBottomLabel:Bool!
    
    
  
    //MARK: Define the text fields attributes
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
        
       disableSaveAndShare(Disable: true)
        
        registerObservers()
        
        let clearTextDelegate = ClearTextFieldDelegate()
        topLabel.delegate = clearTextDelegate as! UITextFieldDelegate
        bottomLabel.delegate = clearTextDelegate as! UITextFieldDelegate
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(  animated)
        unRegisterObservers()
    }
    
    @IBAction func shareImage(_ sender: Any) {
        let image:UIImage  = generateMemedImage()
        let meme:MeMe = MeMe(topText: topLabel.text ?? "", bottomText: bottomLabel.text ?? "" , originalImage: mainImageView.image!, resultImage: image)
        
        let contoller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
       
        present(contoller, animated: true, completion: nil)
        
        
    
        
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
            disableSaveAndShare(Disable: false)
            dismiss(animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        
    }
    
    @objc func hideKeyBoard(){
        print ("Hide keyboard")
        view.endEditing(true)
    }
    
    @objc func keyboardWillShow(_ notification:Notification){
        if bottomLabel.isEditing{
            isBottomLabel = true
            view.frame.origin.y -= getKeyboardHeight(notification)
        }else {
            isBottomLabel = false
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification){
        if isBottomLabel{
            
            view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    @objc func getKeyboardHeight(_ notification:Notification)->CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func registerObservers(){
        tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func unRegisterObservers(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        view.removeGestureRecognizer(tap)
    }
    
    
    
    func generateMemedImage()->UIImage{
        
        hideNavAndToolBar(Hide: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        hideNavAndToolBar(Hide: false)
        
        return memedImage
        
    }
    
    func hideNavAndToolBar(Hide hide:Bool){
       
            navigationBar.isHidden = hide
            toolBar.isHidden  = hide
       
    }
    
    func disableSaveAndShare(Disable disable:Bool){
        shareButton.isEnabled = !disable
        saveButton.isEnabled = !disable
    }
}


