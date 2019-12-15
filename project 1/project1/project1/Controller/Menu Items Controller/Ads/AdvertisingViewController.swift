//
//  AdvertisingViewController.swift
//  project1
//
//  Created by Admin on 11/28/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class AdvertisingViewController: UIViewController , NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var menuoBtn: UIBarButtonItem!
    
    @IBOutlet weak var adsTabelView: UITableView!
    var adsArray = [AllAdvertizmentsResponseAdvertisements]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //make menu
        displayMenu(menuButton : menuoBtn)
        
        // Do any additional setup after loading the view.
        changeTitleColor()
        transperantNavigation()
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
        //network
        networking (url : "http://menyazod.com/api/advertisements", header : [:],parameters: [:])
    }
    
    @IBAction func addAdsBtn(_ sender: Any) {
        let storyboard = UIStoryboard(name: "MyAdvertising", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "addAdsViewController")as! AddAdsViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
  

}

//MARK:- tabel view and networking API
extension AdvertisingViewController : UITableViewDataSource, UITableViewDelegate  {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return adsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "advertizmentTableViewCell", for: indexPath) as! AdvertizmentTableViewCell
        
        cell.adsName = adsArray[indexPath.row].name
        cell.adsPrice = "\(adsArray[indexPath.row].price!)"
        cell.adsUserName = adsArray[indexPath.row].user_name
        cell.adsDescription = adsArray[indexPath.row].description
        cell.adsLacation = adsArray[indexPath.row].city
        cell.adsImageView.kf.setImage(with: URL(string: (adsArray[indexPath.row].image!)), placeholder: UIImage(named: "group_1"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected ads")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllAdvertizmentsResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: AllAdvertizmentsResponse) {
        for ad in (dataResponse.data?.advertisements)! {
            adsArray.append(ad)
        }
        print(adsArray)
        adsTabelView.reloadData()
    }

}
