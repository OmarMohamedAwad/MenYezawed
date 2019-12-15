//
//  SliderCollectionViewCell.swift
//  project1
//
//  Created by Admin on 11/10/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sliderImageView: UIImageView!
    @IBOutlet weak var sliderLebel: UILabel!
    
    var image : UIImage! {
        didSet {
            sliderImageView.image = image
        }
    }
    
    var sliderText : String! {
        didSet {
            sliderLebel.text = sliderText
        }
    }
    
}
