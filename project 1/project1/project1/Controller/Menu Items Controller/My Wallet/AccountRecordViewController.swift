//
//  AccountRecordViewController.swift
//  project1
//
//  Created by Admin on 11/11/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher

class AccountRecordViewController: UIViewController {

    @IBOutlet weak var historyRecordTabelView: UITableView!
    
    
    var imageArray = [UIImage(named: "mastercard"),UIImage(named: "mastercard"),UIImage(named: "mastercard"),UIImage(named: "mastercard"),UIImage(named: "mastercard")]
    var detailsArray = ["Added 100 RY","Added 100 RY","Added 100 RY","Added 100 RY","Added 100 RY"]
    var dateArray = ["20/10/2019 - 3.30 pm","20/10/2019 - 3.30 pm","20/10/2019 - 3.30 pm","20/10/2019 - 3.30 pm","20/10/2019 - 3.30 pm"]
    
    var historyRecordListArray = [GetAllHistoryResponseTransactions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //make navigation setup
        transperantNavigation()
        changeTitleColor()
        
        // Do any additional setup after loading the view.
        
        //networking
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/user/transactions", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
        else {
            let storyboard = UIStoryboard(name: "AuthinticationStoryboard", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "authenticationViewController")as! AuthenticationViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    


}

extension AccountRecordViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyRecordListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "accountRecordTableViewCell", for: indexPath) as! AccountRecordTableViewCell
        
        //cell.recordImage = imageArray[indexPath.row]
        let notificationInfo = "\(historyRecordListArray[indexPath.row].text!) \(historyRecordListArray[indexPath.row].reason!)"
        cell.recordTitle = notificationInfo
        cell.date = historyRecordListArray[indexPath.row].created_at
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected history Record")
                // Convert JSON String to Model
                let responseModel = Mapper<GetAllHistoryResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: GetAllHistoryResponse) {
        for record in (dataResponse.data?.transactions)! {
            historyRecordListArray.append(record)
        }
        //print(historyRecordListArray)
        historyRecordTabelView.reloadData()
    }


    
}
