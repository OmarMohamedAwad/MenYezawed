//
//  ChattingOtherTableViewCell.swift
//  project1
//
//  Created by Admin on 11/21/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class ChattingOtherTableViewCell: UITableViewCell {

    @IBOutlet weak var containerMessageView: SpecialView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var messageDateLabel: UILabel!
    
    var message : String! {
        didSet {
            messageLabel.text = message
        }
    }
    
    var date : String! {
        didSet {
            messageDateLabel.text = date
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
