//
//  ContactUsViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class ContactUsViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make navigation setup
        transperantNavigation()
        changeTitleColor()
        
        //make menu
        displayMenu(menuButton : menuBtn)
        
        //networking
        networking (url : "http://menyazod.com/api/contact", header : [:],parameters: [:])
    }
    
    @IBAction func facebookBtn(_ sender: Any) {
    }
    
    @IBAction func twitterBtn(_ sender: Any) {
    }
    
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected contactus")
                // Convert JSON String to Model
                let responseModel = Mapper<ContactResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: ContactResponse) {
        emailLabel.text = dataResponse.data?.email
        phoneNumberLabel.text = dataResponse.data?.phone
    }


}
