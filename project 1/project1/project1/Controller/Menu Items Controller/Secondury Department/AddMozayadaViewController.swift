//
//  AddMozayadaViewController.swift
//  project1
//
//  Created by Admin on 11/21/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit

class AddMozayadaViewController: UIViewController {
    
    @IBOutlet weak var alertVuew: UIView!
    @IBOutlet weak var alerttextField: UITextField!
    @IBOutlet weak var confirmAlertBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func confirmAddMozayada(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "confirmMozayadaViewController")as! ConfirmMozayadaViewController
        VC.confirmDeleget = self
        VC.modalPresentationStyle = .overCurrentContext
        present(VC, animated: true, completion: nil)
        
    }
    
    @IBAction func dissmisBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension AddMozayadaViewController: ConfirmAlertDelegate{
    func confirm() {
        dismiss(animated: true, completion: nil)
    }
    
    
}
