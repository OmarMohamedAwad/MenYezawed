//
//  AccountRecordTableViewCell.swift
//  project1
//
//  Created by Admin on 11/11/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class AccountRecordTableViewCell: UITableViewCell {
    @IBOutlet weak var recordImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLebel: UILabel!
    
    var recordImage : UIImage! {
        didSet {
            recordImageView.image = recordImage
        }
    }
    
    var recordTitle : String! {
        didSet {
            titleLabel.text = recordTitle
        }
    }
    
    var date : String! {
        didSet {
            dateLebel.text = date
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
