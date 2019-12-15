//
//  LoseViewController.swift
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

class LoseViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    var imageArray = [UIImage(named: "slider1")]
    var nameArray = ["Every thing find in mn yezode"]
    var productNameArray = ["Broun Couch"]
    var priceArray = ["500Ry"]
    var loseArray = [AllProductsResponseAuctions]()
    
    @IBOutlet weak var loseTabelView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
        //Network
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/user/auctions", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
    }
    
    //MARK:- Networking and parsing API
  func networking (url : String, header : [String : String],parameters: [String : String])
  {
      Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
          if response.result.isSuccess
          {
              print("connected Lose")
              self.stopAnimating(nil)
              // Convert JSON String to Model
              let responseModel = Mapper<AllProductsResponse>().map(JSONObject: response.result.value)
              self.fillDataFromAPI(dataResponse: responseModel!)
          }
      }

  }
     
  
  func fillDataFromAPI(dataResponse: AllProductsResponse) {
      for products in (dataResponse.data?.auctions)! {
          loseArray.append(products)
      }
      print(loseArray)
      loseTabelView.reloadData()
  }

}

extension LoseViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return imageArray.count
        return loseArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as! ProductTableViewCell
        
//        cell.imageProduct = imageArray[indexPath.row]
//        cell.productName = productNameArray[indexPath.row]
//        cell.dateExpire = productNameArray[indexPath.row]
//        cell.price = priceArray[indexPath.row]
//        cell.productDetail = nameArray[indexPath.row]

        cell.productImage.kf.setImage(with: URL(string: (loseArray[indexPath.row].image!)), placeholder: UIImage(named: "slider1"))
        cell.productName = loseArray[indexPath.row].name
        cell.dateExpire = loseArray[indexPath.row].duration_status
        cell.price = "\(loseArray[indexPath.row].price!)"
        cell.productDetail = loseArray[indexPath.row].description
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120;
    }

    
}
