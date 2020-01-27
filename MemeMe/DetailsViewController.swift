//
//  DetailsViewController.swift
//  MemeMe
//
//  Created by Hassan on 25/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var myImageView: UIImageView!
    var meme:MeMe!
    
    //MARK: Read the meme
    override func viewDidLoad() {
        super.viewDidLoad()
        myImageView.contentMode = .scaleAspectFit
        if let meme = meme{
            myImageView.image = meme.resultImage
        }
    }
    
    
    
    
}
