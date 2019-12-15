//
//  AdvertizmentTableViewCell.swift
//  project1
//
//  Created by Admin on 11/28/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class AdvertizmentTableViewCell: UITableViewCell {

    @IBOutlet weak var adsImageView: UIImageView!
    @IBOutlet weak var adsNameLabel: UILabel!
    @IBOutlet weak var adsPriceLabel: UILabel!
    @IBOutlet weak var adsDateLabel: UILabel!
    @IBOutlet weak var adsUserNameLabel: UILabel!
    @IBOutlet weak var adsDescriptionLabel: UILabel!
    @IBOutlet weak var adsLacationLabel: UILabel!
    
    
    var imageAds : UIImage! {
        didSet {
            adsImageView.image = imageAds
        }
    }
    
    var adsName : String! {
        didSet {
            adsNameLabel.text = adsName
        }
    }
    
    var adsPrice : String! {
        didSet {
            adsPriceLabel.text = adsPrice
        }
    }
    
    var adsUserName : String! {
        didSet {
            adsUserNameLabel.text = adsUserName
        }
    }
    
    var adsDescription : String! {
        didSet {
            adsDescriptionLabel.text = adsDescription
        }
    }
    
    var adsLacation : String! {
        didSet {
            adsLacationLabel.text = adsLacation
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


