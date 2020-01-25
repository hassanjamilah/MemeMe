//
//  DetailsViewController.swift
//  MemeMe
//
//  Created by user on 25/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    var meme:MeMe!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let meme = meme{
            
            myImageView.image = meme.resultImage
        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
