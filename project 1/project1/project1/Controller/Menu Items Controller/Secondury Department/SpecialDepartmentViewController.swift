//
//  SpecialDepartmentViewController.swift
//  project1
//
//  Created by Admin on 11/14/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class SpecialDepartmentViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()

    @IBOutlet weak var menuoBtn: UIBarButtonItem!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var productTabelView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var imageArray = [UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1")]
    var nameArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode", "Every thing find in mn yezode"]
    var productNameArray = ["Broun Couch","Broun Couch","Broun Couch","Broun Couch", "Broun Couch"]
    var priceArray = ["500Ry","500Ry","500Ry","500Ry", "500Ry"]
    
    var timer : Timer?
    var currantIndex = 0
    var id = 0
    
    var productListArray = [AllProductsResponseAuctions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make menu
        displayMenu(menuButton : menuoBtn)
       
        startTimer()
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
        //Network
        networking (url : "http://menyazod.com/api/auctions/sub_category/\(id)", header : [:],parameters: [:])
    }
        
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        
        let scrollPosition = (currantIndex < imageArray.count - 1) ? currantIndex + 1 : 0
        sliderCollectionView.scrollToItem(at: IndexPath(item: scrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func searchBtn(_ sender: Any) {
        if(searchTextField.text?.isEmpty)! {
                    
            let alert = UIAlertController(title: "Invalid Inputs", message: "Search text is required", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
            
        }
            
        else {
             //loedding
             let size = CGSize(width: 100, height: 100)
             startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)

             guard let searchText = searchTextField.text else {return}

             self.networkingSearch (url : "http://menyazod.com/api/search/auctions", header : [:],parameters: ["text": searchText])
         }
    }
    

    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                
                print("connected Products")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllProductsResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }

    }
       
    
    func fillDataFromAPI(dataResponse: AllProductsResponse) {
        for products in (dataResponse.data?.auctions)! {
            productListArray.append(products)
        }
        print(productListArray)
        productTabelView.reloadData()
    }
    
    //MARK:- Search Networking and parsing API
    func networkingSearch (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print("connected search")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllProductsResponse>().map(JSONObject: response.result.value)
                self.productListArray.removeAll()
                self.fillDataFromAPI(dataResponse: responseModel!)
                
            }
        }
        
    }

}

extension SpecialDepartmentViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
        cell.image = imageArray[indexPath.item]
        cell.sliderText = nameArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.sliderCollectionView.frame.width, height: sliderCollectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currantIndex = Int(scrollView.contentOffset.x / sliderCollectionView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "specialDepartmentViewController")as! SpecialDepartmentViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}


extension SpecialDepartmentViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productTableViewCell", for: indexPath) as! ProductTableViewCell
        
        //cell.imageProduct = productListArray[indexPath.row]
        cell.productImage.kf.setImage(with: URL(string: (productListArray[indexPath.row].image!)), placeholder: UIImage(named: "slider1"))
        cell.productName = productListArray[indexPath.row].name
        cell.dateExpire = productListArray[indexPath.row].duration_status
        cell.price = "\(productListArray[indexPath.row].price!)"
        cell.productDetail = productListArray[indexPath.row].description
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 120;
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "productViewController")as! ProductViewController
        VC.id = indexPath.row
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
}

