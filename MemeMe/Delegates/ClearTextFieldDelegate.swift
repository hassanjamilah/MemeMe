//
//  clearTextDelegate.swift
//  MemeMe
//
//  Created by user on 19/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import Foundation
import UIKit
class ClearTextFieldDelegate:NSObject ,  UITextFieldDelegate{
  
    /**
     Used to clear the text when begin editing.
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
}

