//
//  ConfirmMozayadaViewController.swift
//  project1
//
//  Created by Admin on 11/21/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

protocol ConfirmAlertDelegate {
    func confirm()
}

class ConfirmMozayadaViewController: UIViewController {
    @IBOutlet weak var alertLabelView: UILabel!
    
    var confirmDeleget : ConfirmAlertDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func cancelAlertBtn(_ sender: Any) {
        confirmDeleget.confirm()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func confirmAlertBtn(_ sender: Any) {
        confirmDeleget.confirm()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func dismissBtn(_ sender: Any) {
        confirmDeleget.confirm()
        dismiss(animated: true, completion: nil)
    }
    
}


extension ConfirmMozayadaViewController : ConfirmAlertDelegate{
    func confirm() {
        dismiss(animated: true, completion: nil)
    }
    
}
