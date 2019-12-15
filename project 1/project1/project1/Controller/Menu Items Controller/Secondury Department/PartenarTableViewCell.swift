//
//  PartenarTableViewCell.swift
//  project1
//
//  Created by Admin on 11/18/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class PartenarTableViewCell: UITableViewCell {

    @IBOutlet weak var partenarDetailLabel: UILabel!
    
    @IBOutlet weak var partenarImage: UIImageView!
    
    var imagePartenar : UIImage! {
        didSet {
            partenarImage.image = imagePartenar
        }
    }
    
    var partenarDetail : String! {
        didSet {
            partenarDetailLabel.text = partenarDetail
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        partenarImage.layer.borderWidth = 1
        partenarImage.layer.masksToBounds = false
        partenarImage.layer.borderColor = UIColor.white.cgColor
        partenarImage.layer.cornerRadius = partenarImage.frame.height/2
        partenarImage.layer.cornerRadius = partenarImage.frame.width/2
        partenarImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
