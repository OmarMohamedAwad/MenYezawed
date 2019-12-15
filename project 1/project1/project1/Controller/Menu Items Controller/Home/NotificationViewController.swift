//
//  notificationViewController.swift
//  project1
//
//  Created by Admin on 11/10/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class NotificationViewController: UIViewController , NVActivityIndicatorViewable {
    
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var notificationTabelView: UITableView!
    var imageArray = [UIImage(named: "group_1"),UIImage(named: "group_1"),UIImage(named: "group_1"),UIImage(named: "group_1"),UIImage(named: "group_1")]
    var notificationArray = ["Added 100 RY","Added 100 RY","Added 100 RY","Added 100 RY","Added 100 RY"]
    
    var notificationListArray = [AllNotificationResponseNotification]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //make navigation setup
        self.title = "Notification"
        transperantNavigation()
        changeTitleColor()
        
        // Do any additional setup after loading the view.
        //networking
        if let token = UserDefaults.standard.string(forKey: "token"){
            //loedding
            let size = CGSize(width: 100, height: 100)
            startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
            networking (url : "http://menyazod.com/api/user/notifications", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
    }
    

}

//MARK:- tabel view and networking API
extension NotificationViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationTableViewCell", for: indexPath) as! NotificationTableViewCell
        
        //cell.notificationimage = notificationListArray[indexPath.item]
        cell.notificationTitle = notificationListArray[indexPath.row].message
        cell.notificationDate = notificationListArray[indexPath.row].date
        cell.notificationImageView.kf.setImage(with: URL(string: (notificationListArray[indexPath.row].image!)), placeholder: UIImage(named: "group_1"))
        return cell
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print("connected notification")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllNotificationResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: AllNotificationResponse) {
        for notification in (dataResponse.data?.notification)! {
            notificationListArray.append(notification)
        }
        print(notificationListArray)
        notificationTabelView.reloadData()
    }

}
