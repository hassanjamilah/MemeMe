//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Hassan on 23/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    @IBOutlet var mTableView: UITableView!
    var memes:[MeMe]!
  
    //MARK: Override the view methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = MeMe.getSharedMemes()
        mTableView.reloadData()
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell
        let row = indexPath.row
        cell.imageView?.image = memes[row].resultImage
        cell.memeTopLabel.text = memes[row].topText
        cell.memeBottomLabel.text = memes[row].bottomText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MeMe.viewDetails(index: indexPath.row, controller: self)
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /**
     Add the delete when swipe action
     */
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let myAciton = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            let row = indexPath.row
            let delegage = UIApplication.shared.delegate as! AppDelegate
            delegage.memes.remove(at: row)
            self.memes = delegage.memes
            self.mTableView.reloadData()
        }
        return [myAciton]
    }
    
}
