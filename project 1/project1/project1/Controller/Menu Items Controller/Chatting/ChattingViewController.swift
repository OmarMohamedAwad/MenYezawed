//
//  ChattingViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import Kingfisher
import NVActivityIndicatorView
//import PusherSwift

class ChattingViewController: UIViewController, NVActivityIndicatorViewable {

    private let presentingIndicatorTypes = {
        return NVActivityIndicatorType.allCases.filter { $0 != .blank }
    }()
    
    @IBOutlet weak var chattingTabelView: UITableView!
    @IBOutlet weak var messageTextField: SpecialTextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    @IBOutlet weak var messageContainerUIView: UIView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    var messageArray = ["Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode","Every thing find in mn yezode", "Every thing find in mn yezode"]
    var dateArray = ["05:10 Pm","05:10 Pm","05:10 Pm","05:10 Pm", "05:10 Pm"]
    var userId = 1
    var chatDetail = ChatDetailsResponseData(chat_id: 0, channel_name: "", total_message: 0)
    var messageList = [AllMessageResponseMessages]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        //make navigation color transoarent
        transperantNavigation()
        changeTitleColor()
        
        //make menu
        displayMenu(menuButton : menuBtn)
        
        //loedding
        let size = CGSize(width: 100, height: 100)
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        if let token = UserDefaults.standard.string(forKey: "token"){
            networking (url : "http://menyazod.com/api/check_chat", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
        
        //loedding
        
        startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
        if let token = UserDefaults.standard.string(forKey: "token"){
            messageNetworking (url : "http://menyazod.com/api/chats", header : ["Authorization": "bearer \(token)"],parameters: [:])
        }
    }
    
    
    @IBAction func SendMessageBtn(_ sender: Any) {
        if(messageTextField.text?.isEmpty)! {
                    
            let alert = UIAlertController(title: "Invalid Inputs", message: "Ener the message", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
                
            }
            
            alert.addAction(action)
            
            present(alert , animated: true , completion: nil)
            
        }
            
        else {
            let size = CGSize(width: 100, height: 100)
            startAnimating(size, message: "", type: presentingIndicatorTypes[2], color: .white, minimumDisplayTime: 2, fadeInAnimation: nil)
                
            guard let message = messageTextField.text else {return}
             if let token = UserDefaults.standard.string(forKey: "token"){
                sendMessageNetworking (url : "http://menyazod.com/api/chats/\((chatDetail.chat_id)!)", header : ["Authorization": "bearer \(token)"], parameters: ["body" : message])
            }
        }
    }
    
    //MARK:- Networking and parsing API
    func networking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print("connected chat")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<ChatDetailsResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPI(dataResponse: responseModel!)
            }
        }
        
    }
       
    
    func fillDataFromAPI(dataResponse: ChatDetailsResponse) {
        
        if (dataResponse.value == true) {
            chatDetail.chat_id = dataResponse.data?.chat_id
            chatDetail.channel_name = dataResponse.data?.channel_name
            chatDetail.total_message = dataResponse.data?.total_message
        }
        else {
           
        }
    }
    
    //MARK:- Get All Message Networking and parsing API
    func messageNetworking (url : String, header : [String : String],parameters: [String : String])
    {
        Alamofire.request(url, method: .get, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print("connected message")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllMessageResponse>().map(JSONObject: response.result.value)
                self.fillDataFromAPIMessage(dataResponse: responseModel!)
            }
        }
        
    }
       
    
    func fillDataFromAPIMessage(dataResponse: AllMessageResponse) {
        
        if (dataResponse.value == true) {
            for message in (dataResponse.data?.messages)! {
                messageList.append(message)
            }
            //print(categoriesListArray)
            chattingTabelView.reloadData()
        }
        else {
           
        }
    }
    
    //MARK:- Networking and parsing API Send message
    func sendMessageNetworking (url : String, header : [String : String],parameters: [String : String])
    {
         Alamofire.request(url, method: .post, parameters: parameters, headers: header).responseJSON { (response) in
            if response.result.isSuccess
            {
                print("connected send message")
                self.stopAnimating(nil)
                // Convert JSON String to Model
                let responseModel = Mapper<AllMessageResponse>().map(JSONObject: response.result.value)
            }
            else {
                print(response.error!)
            }
        }
        
    }
    
    //MARK:- pusher
        
//    var pusher : Pusher!
//    func listenToEvent() {
//        //Pusher setup connection
//        let options = PusherClientOptions(
//            host: .cluster("eu")
//        )
//
//        pusher = Pusher(key: "68d0beb6427fa4714c24", options: options)
//
//        pusher.delegate = self
//
//
//        //Pusher setup listen
//        let myChannel = pusher.subscribe(chatDetail.channel_name)
//
//
//        let _ = myChannel.bind(eventName: "MessageCreated", callback: { (data: Any?) -> Void in
//            print("bind bind bind")
//            if let data = data as? [String : AnyObject] {
//                var message : GetAllMessageResponseMessage = GetAllMessageResponseMessage(id: (data["id"] as? Int)!, content: (data["content"] as? String)!, senderID: (data["sender_id"] as? Int)!, chatID: (data["chat_id"] as? Int)!, type: 0, date: "0")
//                self.messageList.append(message)
//
//
//                self.messageTableView.reloadData()
//            }
//        })
//
//        pusher.connect()
//    }

}

extension ChattingViewController : UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if messageList[indexPath.row].selfs == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chattingTableViewCell", for: indexPath) as! ChattingTableViewCell
            
//            cell.message = messageArray[indexPath.row]
//            cell.date = dateArray[indexPath.row]
            cell.message = messageList[indexPath.row].body
            cell.date = messageList[indexPath.row].date
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "chattingOtherTableViewCell", for: indexPath) as! ChattingOtherTableViewCell
            
//            cell.message = messageArray[indexPath.row]
//            cell.date = dateArray[indexPath.row]
            
            cell.message = messageList[indexPath.row].body
            cell.date = messageList[indexPath.row].date
            
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 70;
    }

}
