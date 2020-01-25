//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by user on 23/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    @IBOutlet var mTableView: UITableView!
    var memes:[MeMe]!
    override func viewDidLoad() {
        super.viewDidLoad()

        print("table view contoller loaded successfully")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memes = MeMe.getSharedMemes()
      // initTempMems()
        mTableView.reloadData()
        
    }
    
    
    func initTempMems(){
        for i in 1...5{
            let meme:MeMe = MeMe(topText: "Hello \(i)", bottomText: "Hi \(i)", originalImage: UIImage(named: "share")!, resultImage: UIImage(named: "share")!)
            memes.append(meme)
        }
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print ("hassan the count is : \(memes.count)")
        //return memes.count
        return memes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell", for: indexPath) as! MemeTableViewCell

        let row = indexPath.row
        cell.imageView?.image = memes[row].resultImage
        cell.memeTopLabel.text = memes[row].topText
        cell.memeBottomLabel.text = memes[row].bottomText
        
        //cell.imageView?.image = UIImage(named: "share")
        print ("hassan Hello cell")
        // Configure the cell...

        return cell
    }
    

  

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        MeMe.viewDetails(index: indexPath.row, controller: self)
    }
    
   
}
