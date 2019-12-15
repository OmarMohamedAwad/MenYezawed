//
//  AddMoneyViewController.swift
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

class AddMoneyViewController: UIViewController, NVActivityIndicatorViewable {
    
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()

    
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var accountNameTextField: UITextField!
    @IBOutlet weak var accountNumberTextField: UITextField!
    @IBOutlet weak var reseatImageField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addReseatImage(_ sender: Any) {
    }
    
    @IBAction func addMonyeRequestBtn(_ sender: Any) {
        if (accountNameTextField.text?.isEmpty)! || (accountNumberTextField.text?.isEmpty)! {
                    
            let alert = UIAlertController(title: "Invalid Inputs", message: "Account Name ,Number and Reaseat are required", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
            
        }
            
        else {
          //loedding
          let size = CGSize(width: 100, height: 100)
          startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
              
          guard let name = accountNameTextField.text else {return}
          guard let number = accountNumberTextField.text else {return}
          guard let image = reseatImageField.text else {return}
         
             if let token = UserDefaults.standard.string(forKey: "token"){
                self.networking (url : "http://menyazod.com/api/user/charge_request", header : ["Authorization": "bearer \(token)"],parameters: ["name": name, "number": number, "image": "image"])
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
        print(dataResponse.value!)
    }
    
}
