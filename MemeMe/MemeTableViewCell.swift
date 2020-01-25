//
//  MemeTableViewCell.swift
//  MemeMe
//
//  Created by user on 25/01/2020.
//  Copyright © 2020 Andalus. All rights reserved.
//

import UIKit

class MemeTableViewCell: UITableViewCell {

    @IBOutlet weak var memeBottomLabel: UILabel!
    @IBOutlet weak var memeTopLabel: UILabel!
    @IBOutlet weak var memeTableImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
