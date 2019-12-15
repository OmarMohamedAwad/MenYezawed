//
//  AddAdsViewController.swift
//  project1
//
//  Created by Admin on 12/2/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import DropDown
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class AddAdsViewController: UIViewController {

    @IBOutlet weak var adNameTextField: UITextField!
    @IBOutlet weak var adPrriceTextField : UITextField!
    @IBOutlet weak var adDescriptionTextField: UITextField!
    @IBOutlet weak var contactTypeTextField: UITextField!
    @IBOutlet weak var mainCategoryDropBtn: UIButton!
    @IBOutlet weak var subCategoryDropBtn: UIButton!
    @IBOutlet weak var countiryDropBtn: UIButton!
    @IBOutlet weak var cityDropBtn: UIButton!
    let textField = UITextField()
    
    var categoriesListArray = [AllCategoriesCategories]()
    var categoriesNameListArray = [String]()
    var countiryListArray = [AllCountiresResponseData]()
    var countiryNameListArray = [String]()
    var subCategoryNameArray = [String]()
    var subCategoryArray = [AllSubCategoriesResponseSubCategories]()
    var cityNameArray = [String]()
    var cityArray = [AllCountiresResponseData]()
    
    var subCategoryId : Int?
    var cityId : Int?
    
    //MARK: - DropDown's
    
    let chooseCategoryDropDown = DropDown()
    let chooseSubDropDown = DropDown()
    let chooseCountiryDropDown = DropDown()
    let chooseCityDropDown = DropDown()
    
    lazy var dropDowns: [DropDown] = {
        return [
            self.chooseCategoryDropDown,
            self.chooseSubDropDown,
            self.chooseCountiryDropDown,
            self.chooseCityDropDown,
        ]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //networking
        networking (url : "http://menyazod.com/api/categories", header : [:],parameters: [:])
        //networking
        networking (url : "http://menyazod.com/api/countries", header : [:],parameters: [:])
        
    }
    
    @IBAction func addAdButton(_ sender: Any) {
    }
    
    //MARK: - Actions
    
    @IBAction func chooseCategory(_ sender: Any) {
        chooseCategoryDropDown.show()
    }
    
    @IBAction func chooseSubCategory(_ sender: Any) {
        chooseSubDropDown.show()
    }
    
    @IBAction func chooseContiry(_ sender: Any) {
        chooseCountiryDropDown.show()
    }
    
    @IBAction func chooseCity(_ sender: Any) {
        chooseCityDropDown.show()
    }
    
    
    
}

//MARK: - Drop down
extension AddAdsViewController {
    
    //MARK: - Setup Drop down
    
    func setupDropDowns() {
        setupChooseCategoryDropDown()
        setupChooseSubCategoryDropDown()
        setupChooseCountiryDropDown()
        setupChooseCityDropDown()
    }
    
    func setupChooseCategoryDropDown() {
        chooseCategoryDropDown.anchorView = mainCategoryDropBtn
        
        chooseCategoryDropDown.bottomOffset = CGPoint(x: 0, y: mainCategoryDropBtn.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseCategoryDropDown.dataSource = categoriesNameListArray
        
        
        // Action triggered on selection
        chooseCategoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.mainCategoryDropBtn.setTitle(item, for: .normal)
                        
            //networking
            self?.cityNetworking (url : "http://menyazod.com/api/sub_categories/\((self?.categoriesListArray[index].id)!)", header : [:],parameters: [:])

        }
        
        
    }
    
    func setupChooseSubCategoryDropDown() {
        chooseSubDropDown.anchorView = subCategoryDropBtn
        
        chooseSubDropDown.bottomOffset = CGPoint(x: 0, y: subCategoryDropBtn.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseSubDropDown.dataSource = subCategoryNameArray
        
        // Action triggered on selection
        chooseSubDropDown.selectionAction = { [weak self] (index, item) in
            self?.subCategoryDropBtn.setTitle(item, for: .normal)
            self?.subCategoryId = self?.subCategoryArray[index].id
        }
    }
    
    func setupChooseCountiryDropDown() {
        chooseCountiryDropDown.anchorView = countiryDropBtn
        
        chooseCountiryDropDown.bottomOffset = CGPoint(x: 0, y: countiryDropBtn.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseCountiryDropDown.dataSource = countiryNameListArray
        
        // Action triggered on selection
        chooseCountiryDropDown.selectionAction = { [weak self] (index, item) in
            self?.countiryDropBtn.setTitle(item, for: .normal)
            
            //networking
            self?.cityNetworking (url : "http://menyazod.com/api/cities/\((self?.countiryListArray[index].id)!)", header : [:],parameters: [:])
        }
        
        
    }
    
    func setupChooseCityDropDown() {
        chooseCityDropDown.anchorView = cityDropBtn
        
        chooseCityDropDown.bottomOffset = CGPoint(x: 0, y: cityDropBtn.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseCityDropDown.dataSource = cityNameArray
        
        // Action triggered on selection
        chooseCityDropDown.selectionAction = { [weak self] (index, item) in
            self?.cityDropBtn.setTitle(item, for: .normal)
            self?.cityId = self?.cityArray[index].id
        }
    }
    
}


//MARK: - Drop down Networking
extension AddAdsViewController {
    
    //MARK:- Category and Countiry Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                if url.contains("categories"){
                    print("connected categories")
                    // Convert JSON String to Model
                    let responseModel = Mapper<AllCategoriesResponse>().map(JSONObject: response.result.value)
                    self.fillDataFromAPI(dataResponse: responseModel!)
                }
                else if  url.contains("countries") {
                    print("connected countries")
                    // Convert JSON String to Model
                    let responseModel = Mapper<AllCountiresResponse>().map(JSONObject: response.result.value)
                    self.fillDataFromAPI(countiryResponse: responseModel!)
                }
                
            }
        }
        
    }
    
    
    func fillDataFromAPI(dataResponse: AllCategoriesResponse? = nil,countiryResponse: AllCountiresResponse? = nil) {
        
        if (dataResponse != nil) {
            for categorieName in (dataResponse?.data?.categories)! {
                categoriesNameListArray.append(categorieName.name!)
            }
            for categorie in (dataResponse?.data?.categories)! {
                categoriesListArray.append(categorie)
            }
            setupChooseCategoryDropDown()
        }
            
        else if (countiryResponse != nil) {
            for countiryName in (countiryResponse?.data)! {
                countiryNameListArray.append(countiryName.name!)
            }
            for countiry in (countiryResponse?.data)! {
                countiryListArray.append(countiry)
            }
            setupChooseCountiryDropDown()
        }
            
        
    }
    
    //MARK:- Category and Countiry Networking and parsing API
    func cityNetworking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                if  url.contains("sub_categories") {
                    print("connected sub_category")
                    // Convert JSON String to Model
                    let responseModel = Mapper<AllSubCategoriesREsponse>().map(JSONObject: response.result.value)
                    self.fillDataFromAPICity(subCategoryResponse: responseModel!)
                }
                else {
                    print("connected city")
                    // Convert JSON String to Model
                    let responseModel = Mapper<AllCountiresResponse>().map(JSONObject: response.result.value)
                    self.fillDataFromAPICity(cityResponse: responseModel!)
                }
                
            }
        }
        
    }
    
    
    func fillDataFromAPICity(subCategoryResponse: AllSubCategoriesREsponse? = nil, cityResponse: AllCountiresResponse? = nil ) {
        
         if (subCategoryResponse != nil) {
            for subCategoryName in (subCategoryResponse?.data?.categories)! {
                subCategoryNameArray.append(subCategoryName.name!)
            }
            for subCategory in (subCategoryResponse?.data?.categories)! {
                subCategoryArray.append(subCategory)
            }
            setupChooseSubCategoryDropDown()
        }
         else {
            for cityName in (cityResponse?.data)! {
                cityNameArray.append(cityName.name!)
            }
            for city in (cityResponse?.data)! {
                cityArray.append(city)
            }
            setupChooseCityDropDown()
        }
        
    }
    
}
