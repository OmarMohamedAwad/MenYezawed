//
//  MenuTableViewCell.swift
//  project1
//
//  Created by Admin on 11/4/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var menuIcon: UIImageView!
    
    @IBOutlet weak var menuTitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
