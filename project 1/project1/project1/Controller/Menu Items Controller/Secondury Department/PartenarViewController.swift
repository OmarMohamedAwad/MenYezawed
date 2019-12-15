//
//  PartenarViewController.swift
//  project1
//
//  Created by Admin on 11/18/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView

class PartenarViewController: UIViewController , NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()

    @IBOutlet weak var partenarTabelView: UITableView!
    
    
    var imageArray = [UIImage(named: "blog_titles_8"),UIImage(named: "blog_titles_8"),UIImage(named: "blog_titles_8"),UIImage(named: "blog_titles_8"),UIImage(named: "blog_titles_8")]
    var nameArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode", "Every thing find in mn yezode"]
    var id = 0
    var partenarArray = [PartenarResponseAuctions]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        
        //Network
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/auctions/replies/\(id)", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "All Partenar"
        transperantNavigation()
        changeTitleColor()
        UINavigationBar.appearance().tintColor = UIColor(red: 59, green: 15, blue: 107)
        
        
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                
                print("connected Partenar")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<PartenarResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }

    }
       
    
    func fillDataFromAPI(dataResponse: PartenarResponse) {
        if dataResponse.value == true {
            for partener in (dataResponse.data?.auctions)! {
                partenarArray.append(partener)
            }
            print(partenarArray)
            partenarTabelView.reloadData()
        }
        
    }

}


extension PartenarViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return imageArray.count
        return partenarArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "partenarTableViewCell", for: indexPath) as! PartenarTableViewCell
        
//        cell.imagePartenar = imageArray[indexPath.row]
//        cell.partenarDetail = nameArray[indexPath.row]

        cell.partenarImage.kf.setImage(with: URL(string: (partenarArray[indexPath.row].image!)), placeholder: UIImage(named: "group_1"))
        cell.partenarDetail = partenarArray[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100;
    }

    
}
