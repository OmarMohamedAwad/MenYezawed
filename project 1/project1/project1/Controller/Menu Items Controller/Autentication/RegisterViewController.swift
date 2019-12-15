//
//  RegisterViewController.swift
//  project1
//
//  Created by Admin on 11/6/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import NVActivityIndicatorView

class RegisterViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func rulesButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "AboutAndContactStoryboard", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "ruleViewController")as! RuleViewController
        VC.menuBtn.isEnabled = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func registerButton(_ sender: Any) {
        if(userNameTextField.text?.isEmpty)! || (phoneNumberTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (confirmPasswordTextField.text?.isEmpty)!{
                  
          let alert = UIAlertController(title: "Invalid Inputs", message: "User Name ,Phone and Password are required", preferredStyle: .alert)
          
          let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
              
          }
          
          alert.addAction(action)
          
          present(alert , animated: true , completion: nil)
          
      }
          
      else {
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
            
        guard let username = userNameTextField.text else {return}
        guard let phone = phoneNumberTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        guard let confirmPassword = confirmPasswordTextField.text else {return}
            
        self.networking (url : "http://menyazod.com/api/auth/register", header : [:],parameters: ["name": username, "phone": phone, "password": password, "password_confirmation":confirmPassword, "fcm_token_ios": "454sda"])
       }
    }
    
    @IBAction func loginButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected register")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<RegisterResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: RegisterResponse) {
//        FTIndicator.showToastMessage("Rigistered")
        UserDefaults.standard.set(dataResponse.data?.token, forKey: "token")
        UserDefaults.standard.set(dataResponse.data?.name, forKey: "userName")
        UserDefaults.standard.set(dataResponse.data?.phone, forKey: "phone")
        UserDefaults.standard.set(dataResponse.data?.image, forKey: "image")
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let VC = storyboard.instantiateViewController(withIdentifier: "homeView")as! ViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }

}
