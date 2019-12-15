//
//  MazayadateViewController.swift
//  project1
//
//  Created by Admin on 11/5/19.
//  Copyright © 2019 omar. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class MazayadateViewController: UIViewController {

    
    
    @IBOutlet weak var winBtn: UIButton!
    @IBOutlet weak var loseBtn: UIButton!
    @IBOutlet weak var borderLoseBtn: UIView!
    @IBOutlet weak var borderWinBtn: UIView!
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuBtn: UIBarButtonItem!

    var Features: Timer!
    let Win = UIStoryboard(name: "MazadatyStoryboard", bundle: nil).instantiateViewController(withIdentifier: "winViewController") as! WinViewController
    
    
    let Lose = UIStoryboard(name: "MazadatyStoryboard", bundle: nil).instantiateViewController(withIdentifier: "loseViewController") as! LoseViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //make navigation color transoarent
        transperantNavigation()
        changeTitleColor()
            
        //make menu
        displayMenu(menuButton : menuBtn)
        
        //Segment
        //inti the view content
        addSubView(controller: Win, loseBorder: true, winBorder: false)
        
        
    }
    
    @objc func timeaction(){
        self.addSubView(controller: self.Win, loseBorder: true, winBorder: false)
    }

    @objc func action(){
        self.addSubView(controller: Lose, loseBorder: false, winBorder: true)
   }
    
    @IBAction func changeContainerViewContent(_ sender: UIButton) {
        
        if sender.tag == 1{
            Features = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(timeaction), userInfo: nil, repeats: false)

        }
        else if sender.tag == 2 {
            Features = Timer.scheduledTimer(timeInterval: 1.00, target: self, selector: #selector(action), userInfo: nil, repeats: false)
            
        }
        
    }
    
    func addSubView(controller : UIViewController, loseBorder : Bool, winBorder : Bool) {
        self.addChild(controller)
        self.contentView.addSubview(controller.view)
        controller.didMove(toParent: self)
        controller.view.frame = CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: self.contentView.frame.height)
        
        borderLoseBtn.isHidden = loseBorder
        borderWinBtn.isHidden = winBorder
    }
    override func viewDidAppear(_ animated: Bool) {
      //  Features.invalidate()
    }

}

