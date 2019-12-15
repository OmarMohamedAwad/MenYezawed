//
//  SeconduryViewController.swift
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

class SeconduryViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var menuoBtn: UIBarButtonItem!
    @IBOutlet weak var secondoryCollectionView: UICollectionView!
    @IBOutlet weak var productCollectionView: UICollectionView!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    var imageArray = [UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1")]
    var titleArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode", "Every thing find in mn yezode"]
    
    
    var depatImageArray = [UIImage(named: "slider1"),UIImage(named: "64979"),UIImage(named: "64979"),UIImage(named: "outdoorfurniture"),UIImage(named: "outdoorfurniture")]
    var departNameArray = ["Product one","Product","Product","Product","Product"]
    var departDetailArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode"]
    
    var categoriesListArray = [AllSubCategoriesResponseSubCategories]()
    
    var timer : Timer?
    var currantIndex = 0
    
    var id = 0
    
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
        networking (url : "http://menyazod.com/api/sub_categories/\(id)", header : [:],parameters: [:])
        print(id)
    }
    

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        
        let scrollPosition = (currantIndex < imageArray.count - 1) ? currantIndex + 1 : 0
        secondoryCollectionView.scrollToItem(at: IndexPath(item: scrollPosition, section: 0), at: .centeredHorizontally, animated: true)
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

             self.networkingSearch (url : "http://menyazod.com/api/search/sub_category", header : [:],parameters: ["text": searchText])
         }
    }
    

}


extension SeconduryViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == secondoryCollectionView {
            return imageArray.count
        }
        else {
            return categoriesListArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == secondoryCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
            
            cell.image = imageArray[indexPath.item]
            cell.sliderText = titleArray[indexPath.row]
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "departmentCollectionViewCell", for: indexPath) as! DepartmentCollectionViewCell
            
            cell.departmentImageView.kf.setImage(with: URL(string: (categoriesListArray[indexPath.row].image!)), placeholder: UIImage(named: "slider1"))
            cell.departmentName = categoriesListArray[indexPath.row].name
            //cell.detail = departDetailArray[indexPath.row]
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == secondoryCollectionView {
            return CGSize(width: self.secondoryCollectionView.frame.width, height: secondoryCollectionView.frame.height)
        }
        else {
            return CGSize(width: self.productCollectionView.frame.width / 2 - 8, height: 200)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currantIndex = Int(scrollView.contentOffset.x / secondoryCollectionView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == productCollectionView {
            let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "specialDepartmentViewController")as! SpecialDepartmentViewController
            VC.id = indexPath.row
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                
                print("connected sub categories")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllSubCategoriesREsponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }

    }
       
    
    func fillDataFromAPI(dataResponse: AllSubCategoriesREsponse) {
        for categorie in (dataResponse.data?.categories)! {
            categoriesListArray.append(categorie)
        }
        productCollectionView.reloadData()
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
                let responseModel = Mapper<AllSubCategoriesREsponse>().map(JSONObject: response.result.value)
                self.categoriesListArray.removeAll()
                self.fillDataFromAPI(dataResponse: responseModel!)
                
            }
        }
        
    }
    
}

