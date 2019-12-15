//
//  NotificationTableViewCell.swift
//  project1
//
//  Created by Admin on 11/10/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class NotificationTableViewCell: UITableViewCell {
    @IBOutlet weak var notificationImageView: UIImageView!
    @IBOutlet weak var notificationLabel: UILabel!
    @IBOutlet weak var notificationDateLabel: UILabel!
    
    var notificationimage : UIImage! {
        didSet {
            notificationImageView.image = notificationimage
        }
    }
    
    var notificationTitle : String! {
        didSet {
            notificationLabel.text = notificationTitle
        }
    }
    
    var notificationDate : String! {
        didSet {
            notificationDateLabel.text = notificationDate
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
