//
//  ViewController.swift
//  project1
//
//  Created by Admin on 11/3/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class ViewController: UIViewController, NVActivityIndicatorViewable {
    
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var menuoBtn: UIBarButtonItem!
    @IBOutlet weak var sliderCollectionView:
    UICollectionView!
    
    @IBOutlet weak var departmentCollectionView: UICollectionView!

    @IBOutlet weak var searchContainerView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var imageArray = [UIImage(named: "outdoorfurniture"),UIImage(named: "64979"),UIImage(named: "slider1"),UIImage(named: "64979"),UIImage(named: "outdoorfurniture")]
    var titleArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode", "Every thing find in mn yezode"]
    
    
    var depatImageArray = [UIImage(named: "outdoorfurniture"),UIImage(named: "64979"),UIImage(named: "64979"),UIImage(named: "outdoorfurniture"),UIImage(named: "outdoorfurniture")]
    var departNameArray = ["Sofa","Charies","Sofa","Charies","Charies"]
    var departDetailArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode"]
    
    var categoriesListArray = [AllCategoriesCategories]()
    var bannersListArray = [BannersResponseData]()
    var categories = "categories"
    var banners = "banners"
    
    var timer : Timer?
    var currantIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //make menu
        displayMenu(menuButton : menuoBtn)
        
        //networking
        networking (url : "http://menyazod.com/api/\(categories)", header : [:],parameters: [:])
        networking (url : "http://menyazod.com/api/\(banners)", header : [:],parameters: [:])
        startTimer()
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       //make navigation color transoarent
       transperantNavigation()
       changeTitleColorWhite()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        
        let scrollPosition = (currantIndex < imageArray.count - 1) ? currantIndex + 1 : 0
        sliderCollectionView.scrollToItem(at: IndexPath(item: scrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    @IBAction func notificationBarButton(_ sender: Any) {
        //networking
        if UserDefaults.standard.string(forKey: "token") != nil{
            let VC = storyboard?.instantiateViewController(withIdentifier: "notificationViewController")as! NotificationViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else {
            let storyboard = UIStoryboard(name: "AuthinticationStoryboard", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "authenticationViewController")as! AuthenticationViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
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
             
             self.networkingSearch (url : "http://menyazod.com/api/search/category", header : [:],parameters: ["text": searchText])
         }
    }
    
}

extension UIViewController {

    func transperantNavigation() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
    }
    
    func changeTitleColor() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 59, green: 15, blue: 107)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
    
    func changeTitleColorWhite() {
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 255, green: 255, blue: 255)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
        
}

extension ViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        if indexPath.row == 0{
    //
    //            chatListURL = nextURL
    //            getAllMessageListNetworking(header: head)
    //            print("more data is louded")
    //
    //        }
    //        print("more data is work")
    //    }
        
    //    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    //
    //        // UITableView only moves in one direction, y axis
    //        let currentOffset = scrollView.contentOffset.y
    //        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    //        if self.messageTableView == scrollView {
    //            if maximumOffset - currentOffset <= 100.0 {
    //                chatListURL = nextURL
    //                getAllMessageListNetworking(header: head)
    //            }
    //            else{
    //                print("the end")
    //            }
    //        }
    //    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == sliderCollectionView {
            return bannersListArray.count
        }
        else {
            return categoriesListArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == sliderCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
            
            cell.sliderImageView.kf.setImage(with: URL(string: (bannersListArray[indexPath.row].image!)), placeholder: UIImage(named: "slider1"))
            //cell.image = imageArray[indexPath.row]
            cell.sliderText = titleArray[indexPath.row]
            return cell
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "departmentCollectionViewCell", for: indexPath) as! DepartmentCollectionViewCell
            
            //cell.departmentImage = depatImageArray[indexPath.item]
            cell.departmentImageView.kf.setImage(with: URL(string: (categoriesListArray[indexPath.row].image!)), placeholder: UIImage(named: "slider1"))
            cell.departmentName = categoriesListArray[indexPath.row].name
            //cell.detail = categoriesListArray[indexPath.row].
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == sliderCollectionView {
            return CGSize(width: self.sliderCollectionView.frame.width, height: sliderCollectionView.frame.height)
        }
        else {
            return CGSize(width: self.departmentCollectionView.frame.width / 2 - 8, height: 200)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currantIndex = Int(scrollView.contentOffset.x / sliderCollectionView.frame.size.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == departmentCollectionView {
            let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "seconduryViewController")as! SeconduryViewController
            VC.id =  categoriesListArray[indexPath.row].id!
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                if url.contains("categories") {
                    print("connected categories")
                    self.stopAnimating(nil)
                    // Convert JSON String to Model
                    let responseModel = Mapper<AllCategoriesResponse>().map(JSONObject: response.result.value)
                    self.fillDataFromAPI(dataResponse: responseModel!)
                }
                else if  url.contains("banners") {
                    print("connected banners")
                    // Convert JSON String to Model
                    let responseModel = Mapper<BannersResponse>().map(JSONObject: response.result.value)
                    self.fillDataFromAPI(bannerResponse: responseModel!)
                }
                
            }
        }
        
    }
       
    
    func fillDataFromAPI(dataResponse: AllCategoriesResponse? = nil,bannerResponse: BannersResponse? = nil ) {
        
        if (dataResponse != nil) {
            for categorie in (dataResponse?.data?.categories)! {
                categoriesListArray.append(categorie)
            }
            //print(categoriesListArray)
            departmentCollectionView.reloadData()
        }
        else {
            for banner in (bannerResponse?.data)! {
                bannersListArray.append(banner)
            }
            //print(bannersListArray)
            sliderCollectionView.reloadData()
        }
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
                let responseModel = Mapper<AllCategoriesResponse>().map(JSONObject: response.result.value)
                self.categoriesListArray.removeAll()
                self.fillDataFromAPI(dataResponse: responseModel!)
                
            }
        }
        
    }

}


    
    
