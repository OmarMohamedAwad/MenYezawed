//
//  AuthenticationViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import NVActivityIndicatorView
import UIView_Shake
import EMSpinnerButton

class AuthenticationViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Shake
        self.view.shake()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func forgetButton(_ sender: UIButton) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "forgetPasswordViewController")as! ForgetPasswordViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func loginButton(_ sender: UIButton) {
        if(phoneNumberTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)!{
                   
           let alert = UIAlertController(title: "Invalid Inputs", message: "Phone and Password are required", preferredStyle: .alert)
           
           let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
               
           }
           // Shake with a custom speed and direction
           self.view.shake(10,              // 10 times
                           withDelta: 5.0,  // 5 points wide
                           speed: 0.03,     // 30ms per shake
               shakeDirection: ShakeDirection.vertical
           )
           
           alert.addAction(action)
           
           present(alert , animated: true , completion: nil)
           
       }
           
       else {
        //loginBtn.animate(animation: .collapse)
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
            
        guard let phone = phoneNumberTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        self.networking (url : "http://menyazod.com/api/auth/login", header : [:],parameters: ["password": password, "phone": phone, "fcm_token_ios": "dasadda"])
        }
    }
    
    @IBAction func registerButton(_ sender: UIButton) {
        let VC = storyboard?.instantiateViewController(withIdentifier: "registerViewController")as! RegisterViewController
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print(response)
                print("connected login")
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
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let VC = storyboard.instantiateViewController(withIdentifier: "homeView")as! ViewController
            self.navigationController?.pushViewController(VC, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Invalid Inputs", message: "Phone and Password are required", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
        }
        
    }

    
}
