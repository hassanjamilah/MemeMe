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
    
    
}
