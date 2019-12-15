//
//  MyAccountTableViewCell.swift
//  project1
//
//  Created by Admin on 11/10/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class MyAccountTableViewCell: UITableViewCell {

    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var bankNameLabel: UILabel!
    @IBOutlet weak var estbianNumberLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    
    var bankImage : UIImage! {
        didSet {
            bankImageView.image = bankImage
        }
    }
    
    var bankName : String! {
        didSet {
            bankNameLabel.text = bankName
        }
    }
    
    var estbianNumber : String! {
        didSet {
            estbianNumberLabel.text = estbianNumber
        }
    }
    
    var accountNumber : String! {
        didSet {
            accountNumberLabel.text = accountNumber
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
