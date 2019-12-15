//
//  MyWalletViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class MyWalletViewController: UIViewController {
    
    
    @IBOutlet weak var moneyAmountLabel: UILabel!
    @IBOutlet weak var pullMoneyButton: UIButton!
    @IBOutlet weak var addMoneyButton: UIButton!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var borderAddBtn: UIView!
    @IBOutlet weak var borderPullBtn: UIView!
    var Features: Timer!

    let Add = UIStoryboard(name: "MyWalletStoryboard", bundle: nil).instantiateViewController(withIdentifier: "addMoneyViewController") as! AddMoneyViewController
    
    
    let Pull = UIStoryboard(name: "MyWalletStoryboard", bundle: nil).instantiateViewController(withIdentifier: "pullMoneyViewController") as! PullMoneyViewController
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Do any additional setup after loading the view.
        changeTitleColor()
        transperantNavigation()
        
        //make menu
        displayMenu(menuButton : menuBtn)
        
        //Segment
        //inti the view content
        addSubView(controller : Add, pullBorder : true, addBorder : false)
        
        //networking
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/user/wallet", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
        else {
            let storyboard = UIStoryboard(name: "AuthinticationStoryboard", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "authenticationViewController")as! AuthenticationViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
    }
    
    @objc func timeaction(){
        addSubView(controller : Pull, pullBorder : false, addBorder : true)
    }

    @objc func action(){
       addSubView(controller : Add, pullBorder : true, addBorder : false)
   }
   
    
    @IBAction func recordBarButton(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "accountRecordViewController")as! AccountRecordViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func changeContainerViewContent(_ sender: UIButton) {
        
        if sender.tag == 1{
            Features = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(timeaction), userInfo: nil, repeats: false)
            
        }
        else if sender.tag == 2 {
            Features = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(action), userInfo: nil, repeats: false)
        }
        
    }
    
    func addSubView(controller : UIViewController, pullBorder : Bool, addBorder : Bool) {
        self.addChild(controller)
        self.contentView.addSubview(controller.view)
        controller.didMove(toParent: self)
        controller.view.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        borderPullBtn.isHidden = pullBorder
        borderAddBtn.isHidden = addBorder
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected categories")
                // Convert JSON String to Model
                let responseModel = Mapper<WalletValueResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: WalletValueResponse) {
        moneyAmountLabel.text = "\((dataResponse.data?.wallet)!)"
    }

}

extension UIViewController {
    
    func displayMenu(menuButton : UIBarButtonItem) {
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer((self.revealViewController()?.panGestureRecognizer())!)
        self.revealViewController().rearViewRevealWidth = 290
    }
}
