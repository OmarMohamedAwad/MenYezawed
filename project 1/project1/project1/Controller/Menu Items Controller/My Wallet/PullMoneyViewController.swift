//
//  PullMoneyViewController.swift
//  project1
//
//  Created by Admin on 11/19/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class PullMoneyViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var moneyAmountTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func pullMoneyRequest(_ sender: Any) {
        if (moneyAmountTextField.text?.isEmpty)! {
                    
            let alert = UIAlertController(title: "Invalid Inputs", message: "Value is required", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
            
        }
            
        else {
          //loedding
          let size = CGSize(width: 100, height: 100)
          startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
              
          guard let value = moneyAmountTextField.text else {return}
         
             if let token = UserDefaults.standard.string(forKey: "token"){
                self.networking (url : "http://menyazod.com/api/user/withdrawal_request", header : ["Authorization": "bearer \(token)"],parameters: ["value": value])
            }
         }
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                
                print("connected add money")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AddMoneyResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: AddMoneyResponse) {
        if dataResponse.value == true {
                   
           let alert = UIAlertController(title: "Done", message: "Value is pulled", preferredStyle: .alert)
           
           let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
               
           }
           
           alert.addAction(action)
           
           present(alert , animated: true , completion: nil)
           
       }
    }
    

}
