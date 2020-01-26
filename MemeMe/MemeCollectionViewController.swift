//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Hassan on 23/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MemeCollectionViewCell"

class MemeCollectionViewController: UICollectionViewController {
    var memes:[MeMe]!;
    var itemsPersRow:CGFloat = 3.0
     var space:CGFloat = 3.0
    var currentWidth:CGFloat!
    @IBOutlet var mCollectionView: UICollectionView!
  
    
    //MARK: Overrid the view methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape{
            itemsPersRow = 5.0
                       space = 5.0
            currentWidth = size.width
        }else {
            itemsPersRow = 3.0
            space = 3.0
            currentWidth = size.width
        }
    }
    
    /**
     Listen for device orientation changes
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        itemsPersRow = 3.0
        memes = MeMe.getSharedMemes() ;
        mCollectionView.reloadData()
    }

    
    
    // MARK: Collection View Delegate
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let index = indexPath.row ;
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.label.text=memes[index].topText
        cell.imageView.image = memes[index].resultImage
        return cell
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        MeMe.viewDetails(index: indexPath.row, controller: self)
    }
    

}


//MARK: Extenstion for handling the flow layout

extension MemeCollectionViewController:UICollectionViewDelegateFlowLayout{
    
    /**
     Set the size of the item
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if (currentWidth == nil){
            currentWidth = view.frame.size.width
        }
        let dimension = ( currentWidth - (itemsPersRow*space))/itemsPersRow
        return CGSize(width: dimension, height: dimension)
    }
    
    /**
     Set the vertical spacing
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
    /**
     Set the horizonal spacing
     */
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return space
    }
    
}
