//
//  ProfileViewController.swift
//  project1
//
//  Created by Admin on 11/11/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import NVActivityIndicatorView

class ProfileViewController: UIViewController ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, NVActivityIndicatorViewable{
    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var menuoBtn: UIBarButtonItem!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cameButton: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    
    var disapeare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //make navigation setup
        transperantNavigation()
        changeTitleColor()
        
        //make menu
        displayMenu(menuButton : menuoBtn)
        
        //disable textfield
        makeViewDisable(enabel : disapeare)
        passwordTextField.isUserInteractionEnabled = false
        
        //Make Imagw Rounded
        //makeImageRounded(image : profileImage)
        
        //display user data
        displayUserData()
        
    }
    
    @IBAction func pickImageButton(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage //2
        profileImage.contentMode = .scaleAspectFill //3
        profileImage.image = chosenImage //4
        dismiss(animated: true, completion: nil) //5
    }
    
    @IBAction func changePasswordBtn(_ sender: Any) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "changePasswordViewController")as! ChangePasswordViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        //loedding
        if let token = UserDefaults.standard.string(forKey: "token"){
            let size = CGSize(width: 100, height: 100)
            startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
            
            guard let phone = phoneNumberTextField.text else {return}
            guard let userName = userNameTextField.text else {return}
            self.networking (url : "http://menyazod.com/api/user/update/profile", header : ["Authorization": "bearer \(token)"],parameters: ["name": userName,"phone": phone])
            makeViewDisable(enabel : !disapeare)
        }
        
        
    }
    
    
    @IBAction func settingBarButton(_ sender: Any) {
        makeViewDisable(enabel : !disapeare)
    }
    
    
    func makeViewDisable(enabel : Bool){
        userNameTextField.isUserInteractionEnabled = enabel
        phoneNumberTextField.isUserInteractionEnabled = enabel
        saveButton.isHidden = !enabel
        cameButton.isHidden = !enabel
        disapeare = enabel
    }
    
    func displayUserData() {
        if let name = UserDefaults.standard.string(forKey: "userName"), let phone = UserDefaults.standard.string(forKey: "phone"), let image = UserDefaults.standard.string(forKey: "image"){
            print(name)
            userNameTextField.text = "\(name)"
            phoneNumberTextField.text = "\(phone)"
            
            
            let url = URL(string: image)
            profileImage.kf.setImage(with: url, placeholder: UIImage(named: "blog_titles_8"))
        }
        
    }
    
    override func viewDidLayoutSubviews() {
       profileImage.backgroundColor = .white
       profileImage.layer.cornerRadius = CGFloat(profileImage.frame.height / 2)
       let shadowLayer = CAShapeLayer()
       shadowLayer.fillColor = UIColor.green.cgColor //3
       shadowLayer.shadowColor = UIColor.green.cgColor //4
       shadowLayer.shadowOffset = CGSize(width: 5, height: 2)  //5
       shadowLayer.shadowOpacity = 2
       shadowLayer.shadowRadius = 5
       profileImage.layer.insertSublayer(shadowLayer, at: 0)//(shadowLayer)
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected edit profile")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<RegisterResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }

    func fillDataFromAPI(dataResponse: RegisterResponse) {
        if dataResponse.value == true {
           //print(dataResponse.data?.name)
           UserDefaults.standard.set(dataResponse.data?.token, forKey: "token")
           UserDefaults.standard.set(dataResponse.data?.name, forKey: "userName")
           UserDefaults.standard.set(dataResponse.data?.phone, forKey: "phone")
           UserDefaults.standard.set(dataResponse.data?.image, forKey: "image")
           
           userNameTextField.text = dataResponse.data?.name
           phoneNumberTextField.text = dataResponse.data?.phone
           
       }
        else {
            let alert = UIAlertController(title: "Invalid Inputs", message: "Phone and User Name are invailed", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
        }
       
    }

}
