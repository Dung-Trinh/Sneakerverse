//
//  MyProfilViewController.swift
//  SneakerApp
//
//  Created by Dung  on 23.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import Kingfisher
import UserNotifications

class MyProfilViewController: UIViewController {

    @IBOutlet weak var img: UIImageView!
    func createGradientBackground() {
        var gradientLayer = CAGradientLayer()
              
                 gradientLayer.frame = self.view.bounds
                 var blau = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
                 var pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
                 var blau2 = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor

                 gradientLayer.colors = [pink,blau,blau2]
              
                 self.view.layer.addSublayer(gradientLayer)
                 self.view.layer.insertSublayer(gradientLayer, at: 0)

       }
    func loadImage(url:String) {
            let imageURL = URL(string: url)!
        img.kf.indicatorType = .activity
        img.kf.setImage(with: imageURL)
        img.layer.cornerRadius = 40
        img.clipsToBounds = true
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientBackground()
        loadImage(url: "https://cdn.imgbin.com/5/5/20/imgbin-slipper-crocs-shoe-clog-sandal-minions-cartoon-K2cLspqdiDUbUUZh6TxBD7LDt.jpg")
        
  


    }

 
}
