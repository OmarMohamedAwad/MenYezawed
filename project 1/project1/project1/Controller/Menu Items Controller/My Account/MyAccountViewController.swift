//
//  MyAccountViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class MyAccountViewController: UIViewController {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var myAccountTabelView: UITableView!
    
    var imageArray = [UIImage(named: "group_1"),UIImage(named: "group_1"),UIImage(named: "group_1"),UIImage(named: "group_1"),UIImage(named: "group_1")]
    var bankNameArray = ["Bank EL Ahly","Bank EL Ahly","Bank EL Ahly","Bank EL Ahly","Bank EL Ahly"]
    var estebianNumberArray = ["01412001518","01412001518","01412001518","01412001518","01412001518"]
    var accountNumberArray = ["01412001518","01412001518","01412001518","01412001518","01412001518"]
    
    var allAccountArray = [AllMyAccountResponseBankAccounts]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeTitleColor()
        transperantNavigation()
        
        //make menu and setup navigation
        displayMenu(menuButton : menuBtn)
        
        //networking
        networking (url : "http://menyazod.com/api/bank-accounts", header : [:],parameters: [:])
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected account")
                // Convert JSON String to Model
                let responseModel = Mapper<AllMyAccountResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: AllMyAccountResponse) {
        for account in (dataResponse.data?.bankAccounts)! {
            allAccountArray.append(account)
        }
        print(allAccountArray)
        myAccountTabelView.reloadData()
    }

}

extension MyAccountViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allAccountArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myAccountTableViewCell", for: indexPath) as! MyAccountTableViewCell
        
        cell.bankImageView.kf.setImage(with: URL(string: (allAccountArray[indexPath.row].image!)), placeholder: UIImage(named: "group_1"))
        cell.bankName = allAccountArray[indexPath.item].bank
        cell.accountNumber = allAccountArray[indexPath.item].number
        cell.estbianNumber = allAccountArray[indexPath.item].iban
        return cell
    }

    
}
