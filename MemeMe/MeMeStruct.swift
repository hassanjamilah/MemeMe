//
//  MeMeStruct.swift
//  MemeMe
//
//  Created by Hassan on 19/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//
import UIKit
struct  MeMe {
    var topText:String
    var bottomText:String
    var originalImage:UIImage
    var resultImage:UIImage
    
    static func getSharedMemes() -> [MeMe]{
        let delegage = UIApplication.shared.delegate as! AppDelegate
        return delegage.memes
    }

    
    
    
}


