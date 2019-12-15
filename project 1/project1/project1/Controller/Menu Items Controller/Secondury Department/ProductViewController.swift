//
//  ProductViewController.swift
//  project1
//
//  Created by Admin on 11/17/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class ProductViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()

    @IBOutlet weak var menuoBtn: UIBarButtonItem!
    @IBOutlet weak var productSlider: UICollectionView!
    
    @IBOutlet weak var pageController: UIPageControl!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productInfo: UILabel!
    
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var minuteLabel: UILabel!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBOutlet weak var higherLabel: UILabel!
    @IBOutlet weak var lessLabel: UILabel!
    @IBOutlet weak var startAtLabel: UILabel!
    @IBOutlet weak var endAtLabel: UILabel!
    @IBOutlet weak var minimumLabel: UILabel!
    @IBOutlet weak var mozayedinLabel: UILabel!
    
    var id = 0
    
    @IBOutlet weak var mozayadaTextLabel: UITextField!
    
    
    var imageArray = [UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1"),UIImage(named: "slider1")]
    var sliderImagesArray = [SpecialProductResponseDataGalleries]()
    
    var timer : Timer?
    var currantIndex = 0
    var productId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make menu
        displayMenu(menuButton : menuoBtn)
        
        
        startTimer()
        pageController.numberOfPages = imageArray.count
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
        //Network
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/auctions/sub_category/\(id)", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        changeTitleColorWhite()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.barTintColor = UIColor(red: 59, green: 15, blue: 107)
    }
    
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    
    @objc func timerAction() {
        
        let scrollPosition = (currantIndex < imageArray.count - 1) ? currantIndex + 1 : 0
        productSlider.scrollToItem(at: IndexPath(item: scrollPosition, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func addMozayada(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "addMozayadaViewController")as! AddMozayadaViewController
        VC.modalPresentationStyle = .overCurrentContext
               present(VC, animated: true, completion: nil)
    }
    
    @IBAction func allPartenar(_ sender: Any) {
        let storyboard = UIStoryboard(name: "SecondryDepartmentStoryboard", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "partenarViewController")as! PartenarViewController
        VC.id = productId
        self.navigationController?.pushViewController(VC, animated: true)
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
                let responseModel = Mapper<SpecialProductResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }

    }
       
    
    func fillDataFromAPI(dataResponse: SpecialProductResponse) {
        if dataResponse.value == true {
            for sliderImage in (dataResponse.data?.galleries)! {
                sliderImagesArray.append(sliderImage)
            }
            print(sliderImagesArray)
            productSlider.reloadData()
            
            productId = (dataResponse.data?.id)!
            productName.text = dataResponse.data?.name
            productInfo.text = dataResponse.data?.description
            productPrice.text = "\(String(describing: dataResponse.data?.price!))"
            
            startAtLabel.text = dataResponse.data?.start_date
            endAtLabel.text = dataResponse.data?.end_date
            minimumLabel.text = "\(String(describing: dataResponse.data?.min_price!))"
            higherLabel.text = "\(String(describing: dataResponse.data?.highest_reply!))"
            mozayedinLabel.text = "\(String(describing: dataResponse.data?.replies))"
            lessLabel.text = "\(String(describing: dataResponse.data?.last_reply_amount))"
            
            dayLabel.text = dataResponse.data?.rest_days
            secondLabel.text = "\(String(describing: dataResponse.data?.rest_time_seconds))"
            
            hourLabel.text = dataResponse.data?.rest_time
            
        }
        
    }

}

extension ProductViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell

        cell.image = imageArray[indexPath.item]
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: self.productSlider.frame.width, height: productSlider.frame.height)

    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currantIndex = Int(scrollView.contentOffset.x / productSlider.frame.size.width)
        pageController.currentPage = currantIndex
    }


}


extension UIViewController {


}

