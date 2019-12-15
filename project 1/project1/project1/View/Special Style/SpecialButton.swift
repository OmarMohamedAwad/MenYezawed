//
//  SpecialButton.swift
//  project1
//
//  Created by Admin on 11/6/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
//@IBDesignable

class SpecialButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 0 {
       didSet {
           layer.cornerRadius = cornerRadius
           layer.masksToBounds = cornerRadius > 0
       }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
       didSet {
           layer.borderWidth = borderWidth
       }
    }
    @IBInspectable var borderColor: UIColor? {
       didSet {
        layer.borderColor = borderColor?.cgColor
       }
    }
}

class SpecialAdButton: UIButton {
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    func setup(){
        self.titleEdgeInsets = UIEdgeInsets(top: 10,left: 15,bottom: 10,right: 10)
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        
      }
}

class SpecialTextField: UITextField {

//    @IBInspectable var cornerRadius: CGFloat = 5 {
//       didSet {
//           layer.cornerRadius = cornerRadius
//           layer.masksToBounds = cornerRadius > 0
//       }
//    }
//    @IBInspectable var borderWidth: CGFloat = 1 {
//       didSet {
//           layer.borderWidth = borderWidth
//       }
//    }
//    @IBInspectable var borderColor: UIColor? {
//       didSet {
//        layer.borderColor = borderColor?.cgColor
//       }
//    }
    
    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    func setup(){
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: self.frame.height))
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.gray.cgColor
        self.leftView = padding
        self.rightView = padding
        self.leftViewMode = .always
        self.rightViewMode = .always
      }
}


class SpecialView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 20.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
      }

}

class SpecialProductView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
      self.layer.cornerRadius = 5.0
      self.layer.shadowColor = UIColor.black.cgColor
      self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
      self.layer.shadowRadius = 2.0
      self.layer.shadowOpacity = 0.5
      self.layer.masksToBounds = false
    }

}

class SpecialRoundView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()

    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        setup()

    }
    
    func setup() {
      self.layer.borderWidth = 1
      self.layer.masksToBounds = false
      self.layer.borderColor = UIColor.white.cgColor
      self.layer.cornerRadius = self.frame.height/2
      self.clipsToBounds = true
    }

}


class SpecialCollectionView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
      }

}

class SpecialImageView: UIImageView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      setup()
    }
    
    func setup(){
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = false
      }

}

//class SpecialRoundImage: UIImageView {
//    
//    override init(frame: CGRect) {
//      super.init(frame: frame)
//      setup()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//      super.init(coder: aDecoder)
//      setup()
//    }
//    
//    func setup(){
//        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
//        outerView.clipsToBounds = false
//        outerView.layer.shadowColor = UIColor.black.cgColor
//        outerView.layer.shadowOpacity = 1
//        outerView.layer.shadowOffset = CGSize.zero
//        outerView.layer.shadowRadius = self.bounds.height/2
//        outerView.layer.shadowPath = UIBezierPath(roundedRect: outerView.bounds, cornerRadius: 10).cgPath
//
//        self.frame = outerView.bounds
//        self.clipsToBounds = true
//        self.layer.cornerRadius = self.bounds.height/2
//        //Finally, remember to make the image view a subview of the container view.
//        outerView.addSubview(self)      }
//    
//}

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
}

class SpecialChattingView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup(corners: [.topLeft, .bottomRight, .bottomLeft], radius: 20.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        setup(corners: [.topLeft, .bottomRight, .bottomLeft], radius: 20.0)
    }
    
    func setup(corners: UIRectCorner, radius: CGFloat){
       let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       layer.mask = mask
      }
    
}

class SpecialChattingUserView: UIView {

    override init(frame: CGRect) {
      super.init(frame: frame)
      setup(corners: [.topRight, .bottomRight, .bottomLeft], radius: 20.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
        setup(corners: [.topRight, .bottomRight, .bottomLeft], radius: 20.0)
    }
    
    func setup(corners: UIRectCorner, radius: CGFloat){
       let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
       let mask = CAShapeLayer()
       mask.path = path.cgPath
       layer.mask = mask
      }
    
    

}
