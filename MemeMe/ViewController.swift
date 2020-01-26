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
    
    var originalY:CGFloat!
    var tap:UITapGestureRecognizer!
    var isBottomLabel:Bool!
    
     let clearTextDelegate = ClearTextFieldDelegate()
    
  
    //MARK: Define the text fields attributes
    let textAttributes: [NSAttributedString.Key : Any]=[
        NSAttributedString.Key.font:UIFont(name: "HelveticaNeue-CondensedBlack", size: 24) ,
        NSAttributedString.Key.foregroundColor:UIColor.white ,
        NSAttributedString.Key.strokeWidth:-5 ,
        NSAttributedString.Key.strokeColor:UIColor.black
        
        
    ]
    
    //MARK: Overrided Methods
    
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
        
       
        self.bottomLabel.delegate = clearTextDelegate
        self.topLabel.delegate = clearTextDelegate
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(  animated)
        unRegisterObservers()
    }
    
    
    @IBAction func dismissAddMeme(_ sender: Any) {
        print ("Dismiss")
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //MARK: Actions
    
    @IBAction func shareImage(_ sender: Any) {
        let image:UIImage  = generateMemedImage()
       
        let contoller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
       
        
        
       contoller.completionWithItemsHandler = { (activityType: UIActivity.ActivityType?, completed:
        Bool, arrayReturnedItems: [Any]?, error: Error?) in
            if completed {
                let meme:MeMe = MeMe(topText: self.topLabel.text ?? "", bottomText: self.bottomLabel.text ?? "" , originalImage: self.mainImageView.image!, resultImage: image)
                
                let delegate = UIApplication.shared.delegate as! AppDelegate
                delegate.memes.append(meme) ;
            } else {
                self.dismiss(animated: true, completion: nil)
            }
            if let shareError = error {
                print("error while sharing: \(shareError.localizedDescription)")
            }
        }
        present(contoller, animated: true, completion: nil)

        
    }
    
    
    
    @IBAction func getImageViaCamera(){
        showImagePickerContoller(isCamera: true)
    }
    
    @IBAction func getImageViaGallery(){
        showImagePickerContoller(isCamera: false)
    }
    
    
    
    //MARK: Handle the image operations
    
    /**
     Used to show the image picker
     */
    func showImagePickerContoller(isCamera:Bool){
        let contoller = UIImagePickerController()
        contoller.delegate  = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        if isCamera {
            contoller.sourceType = .camera
        }
        present(contoller, animated: true, completion: nil)
        
    }
    
    /**
     Used to handle the action of handling the image after choosing it
     */
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let image = info[.originalImage]{
            print("image picker  controller")
            mainImageView.image = image as? UIImage
            disableSaveAndShare(Disable: false)
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    /**
     Used to mix the image with the text to generate the final meme image.
     */
   func generateMemedImage()->UIImage{
          
          hideNavAndToolBar(Hide: true)
          
          UIGraphicsBeginImageContext(self.view.frame.size)
          view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
          let memedImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
          UIGraphicsEndImageContext()
          
          hideNavAndToolBar(Hide: false)
          
          return memedImage
          
      }
    
    
    //MARK: Handle the keyboard actions
    
    /**
     Used to hide the keyboard when the user clicked outside the textfield.
     */
    @objc func hideKeyBoard(){
        view.endEditing(true)
    }
    
    /**
     Used to shift the view up when the bottom textfiled begin editing.
     */
    @objc func keyboardWillShow(_ notification:Notification){
        if bottomLabel.isEditing{
            isBottomLabel = true
            originalY = view.frame.origin.y
            view.frame.origin.y -= getKeyboardHeight(notification)
        }else {
            isBottomLabel = false
        }
    }
    
    
    /**
    Return the view to its original position when finished editing.
     */
    @objc func keyboardWillHide(_ notification:Notification){
        if isBottomLabel{
            view.frame.origin.y = originalY
        }
    }
    
    /**
     Used to get the keyboard height. This height is used to know how to shift the view up.
     */
    @objc func getKeyboardHeight(_ notification:Notification)->CGFloat{
        let userInfo = notification.userInfo
        let keyboardSize = userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    
    //MARK: Register and unregister observers.
    
    /**
     Used to register the observers of the keyboard and of the tap action.
     */
    func registerObservers(){
        tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyBoard))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    /**
    Used to unregister the observers of the keyboard and of the tap action.
    */
    func unRegisterObservers(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        view.removeGestureRecognizer(tap)
    }
    
    
    
   
    
    
    //MARK: Add Hiding and Enabling functinality
    
    /**
     Hide or show the toolbar and the navigation bar.
     It's used when combining the image with the text.
     */
    func hideNavAndToolBar(Hide hide:Bool){
       
            navigationBar.isHidden = hide
            toolBar.isHidden  = hide
       
    }
    
    /**
     Enable and disable the save and share button.
     It's used when starting the app because there is no image to share or save
     so we disable them. After choosing an image the buttons will be enabled.
     */
    func disableSaveAndShare(Disable disable:Bool){
        shareButton.isEnabled = !disable
        
    }
}


