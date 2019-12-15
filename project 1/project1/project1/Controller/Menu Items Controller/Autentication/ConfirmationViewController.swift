//
//  ConfirmationViewController.swift
//  project1
//
//  Created by Admin on 11/10/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class ConfirmationViewController: UIViewController {

    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var secondTextField: UITextField!
    @IBOutlet weak var thirdTextField: UITextField!
    @IBOutlet weak var fourthTextField: UITextField!
    
    var phone = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.phoneNumber.text = phone
    }
    


}


extension ConfirmationViewController: UITextFieldDelegate {

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !(string == "") {
            textField.text = string
            if textField == firstTextField {
                secondTextField.becomeFirstResponder()
            }
            else if textField == secondTextField {
                thirdTextField.becomeFirstResponder()
            }
            else if textField == thirdTextField {
                fourthTextField.becomeFirstResponder()
            }
            else {
                textField.resignFirstResponder()
            }
            return false
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if (textField.text?.count ?? 0) > 0 {

        }
        return true
    }
}
