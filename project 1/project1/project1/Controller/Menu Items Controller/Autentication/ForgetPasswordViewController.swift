//
//  ForgetPasswordViewController.swift
//  project1
//
//  Created by Admin on 11/7/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import NVActivityIndicatorView

class ForgetPasswordViewController: UIViewController, NVActivityIndicatorViewable {
    private let presentingIndicatorTypes = {
           return NVActivityIndicatorType.allCases.filter { $0 != .blank }
       }()
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make navigation color transoarent
        transperantNavigation()
        
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if (phoneNumberTextField.text?.isEmpty)! {
                    
            let alert = UIAlertController(title: "Invalid Inputs", message: "Phone is required", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
            
        }
        else {
            //loedding
            let size = CGSize(width: 100, height: 100)
            startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
            
            guard let phone = phoneNumberTextField.text else {return}
            self.networking (url : "http://menyazod.com/api/auth/forget", header : [:],parameters: ["mobile": phone])
            
        }
        
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected forget")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<ForgetPsswordResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }

    func fillDataFromAPI(dataResponse: ForgetPsswordResponse) {
        if dataResponse.value == true {
            let VC = storyboard?.instantiateViewController(withIdentifier: "confirmationViewController")as! ConfirmationViewController
            guard let phone = phoneNumberTextField.text else {return}
            VC.phone = phone
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Invalid Inputs", message: "Phone is incorrect", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
        }
    }

    
}
