//
//  ProductTableViewCell.swift
//  project1
//
//  Created by Admin on 11/14/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var dateExpireLabel: UILabel!
    
    @IBOutlet weak var productDetailLabel: UILabel!
    
    var imageProduct : UIImage! {
        didSet {
            productImage.image = imageProduct
        }
    }
    
    var productName : String! {
        didSet {
            productNameLabel.text = productName
        }
    }
    
    var price : String! {
        didSet {
            priceLabel.text = price
        }
    }
    
    var dateExpire : String! {
        didSet {
            dateExpireLabel.text = dateExpire
        }
    }
    
    var productDetail : String! {
        didSet {
            productDetailLabel.text = productDetail
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
