//
//  MenuViewController.swift
//  project1
//
//  Created by Admin on 11/4/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Kingfisher
import Alamofire
import ObjectMapper
import NVActivityIndicatorView

class MenuViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var userImage: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var menuTableView: UITableView!
    var titleArray = ["Home","My Wallet","Mozaydaty","My Advertising", "My Account","Direct Chatting","Rules","Contact Us","About Us","Login"]
    var storyboardArray = ["Main","MyWalletStoryboard","MazadatyStoryboard", "MyAdvertising","MyAccountStoryboard","DirectChattingStoryboard","AboutAndContactStoryboard","AboutAndContactStoryboard","AboutAndContactStoryboard","AuthinticationStoryboard"]
    var iconArray = ["ionicons_svg_ios_home","wallet","judge", "icon", "ionicons_svg_md_key","ionicons_svg_ios_mail","privacy","ionicons_svg_md_contacts","icon","judge"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // menuTableView.alwaysBounceVertical = false
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let _ = UserDefaults.standard.string(forKey: "token") {
            self.titleArray[9] = "Logout"
            self.iconArray[9] = "ionicons_svg_md_log_in"
            displayUserData()
            menuTableView.reloadData()
        }
        
    }
    
    @IBAction func profileImageButton(_ sender: Any) {
        setMenuFrontView(storyBoard: "AuthinticationStoryboard", vc: "profile")
    }
    
    func displayUserData() {
        
        if let name = UserDefaults.standard.string(forKey: "userName"), let phone = UserDefaults.standard.string(forKey: "phone"), let image = UserDefaults.standard.string(forKey: "image"){
            print(name)
            userNameLabel.text = "\(name)"
            phoneNumberLabel.text = "\(phone)"
            
            
            let url = URL(string: image)
            userImage.kf.setBackgroundImage(with: url, for: .normal, placeholder: UIImage(named: "blog_titles_8"))
        }
        
    }
    

}

extension MenuViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        cell.menuIcon.image = UIImage (named: iconArray[indexPath.row])
        cell.menuTitleLabel.text = titleArray[indexPath.row]
    
        if let _ = UserDefaults.standard.string(forKey: "token"), indexPath.row == 9 {
            cell.menuTitleLabel.textColor = .red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let token = UserDefaults.standard.string(forKey: "token"), indexPath.row == 9 {
            //loedding
            let size = CGSize(width: 100, height: 100)
            startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
            
            self.networking (url : "http://menyazod.com/api/user/logout", header : ["Authorization": "bearer \(token)" ],parameters: [:])
            
            setMenuFrontView(storyBoard: storyboardArray[indexPath.row], vc: "Login")
            
        }
        else {
            setMenuFrontView(storyBoard: storyboardArray[indexPath.row], vc: titleArray[indexPath.row])
        }
        
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                
                UserDefaults.standard.removeObject(forKey: "token")
                UserDefaults.standard.removeObject(forKey: "userName")
                UserDefaults.standard.removeObject(forKey: "phone")
                UserDefaults.standard.removeObject(forKey: "image")
                self.stopAnimating(nil)
                print("connected logout")
                // Convert JSON String to Model
                let responseModel = Mapper<LogoutResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
    
    func fillDataFromAPI(dataResponse: LogoutResponse) {
        print(dataResponse.data!)
    }


    
    
}


extension UIViewController {

    func setMenuFrontView(storyBoard: String, vc: String) {
        let sb = UIStoryboard(name: storyBoard, bundle: nil)
        let vcNew = sb.instantiateViewController(withIdentifier: vc) as! UINavigationController
        self.revealViewController().setFront(vcNew, animated: true)
        self.revealViewController().setFrontViewPosition(FrontViewPosition.left, animated: true)
    }

}
