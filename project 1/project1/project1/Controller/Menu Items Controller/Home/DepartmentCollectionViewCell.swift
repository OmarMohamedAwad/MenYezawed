//
//  DepartmentCollectionViewCell.swift
//  project1
//
//  Created by Admin on 11/14/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class DepartmentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var departmentImageView: UIImageView!
    
    @IBOutlet weak var departmentNameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var departmentImage : UIImage! {
        didSet {
            departmentImageView.image = departmentImage
        }
    }
    
    var departmentName : String! {
        didSet {
            departmentNameLabel.text = departmentName
        }
    }
    
    var detail : String! {
        didSet {
            detailLabel.text = detail
        }
    }
}
