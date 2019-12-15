//
//  RuleViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import ShimmerSwift

class RuleViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var rulesLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make navigation setup 
        transperantNavigation()
        changeTitleColor()
        
        //make menu
        displayMenu(menuButton : menuBtn)
        
        //networking
        networking (url : "http://menyazod.com/api/terms", header : [:],parameters: [:])
        
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected rules")
                // Convert JSON String to Model
                let responseModel = Mapper<AboutResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: AboutResponse) {
        rulesLabel.text = dataResponse.data
    }

}
