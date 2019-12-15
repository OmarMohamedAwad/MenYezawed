//
//  WinViewController.swift
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

class WinViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()

    var imageArray = [UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1")]
    var nameArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode", "Every thing find in mn yezode"]
    var productNameArray = ["Broun Couch","Broun Couch","Broun Couch","Broun Couch", "Broun Couch"]
    var priceArray = ["500Ry","500Ry","500Ry","500Ry", "500Ry"]
    
    @IBOutlet weak var winnerTabelView: UITableView!
    var winnerArray = [AllProductsResponseAuctions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
        //Network
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/user/auctions/winner", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
    }
    
    //MARK:- Networking and parsing API
   func networking (url : String, header : [String : String],parameters: [String : String])
   {
       Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
           if response.result.isSuccess
           {
               print("connected Winner")
               self.stopAnimating(nil)
               // Convert JSON String to Model
               let responseModel = Mapper<AllProductsResponse>().map(JSONObject: response.result.value)
               self.fillDataFromAPI(dataResponse: responseModel!)
           }
       }

   }
      
   
   func fillDataFromAPI(dataResponse: AllProductsResponse) {
       for products in (dataResponse.data?.auctions)! {
           winnerArray.append(products)
       }
       print(winnerArray)
       winnerTabelView.reloadData()
   }
}


extension WinViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return imageArray.count
        return winnerArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as! ProductTableViewCell
        
//        cell.imageProduct = imageArray[indexPath.row]
//        cell.productName = productNameArray[indexPath.row]
//        cell.dateExpire = productNameArray[indexPath.row]
//        cell.price = priceArray[indexPath.row]
//        cell.productDetail = nameArray[indexPath.row]

        cell.productImage.kf.setImage(with: URL(string: (winnerArray[indexPath.row].image!)), placeholder: UIImage(named: "slider1"))
        cell.productName = winnerArray[indexPath.row].name
        cell.dateExpire = winnerArray[indexPath.row].duration_status
        cell.price = "\(winnerArray[indexPath.row].price!)"
        cell.productDetail = winnerArray[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120;
    }

}
