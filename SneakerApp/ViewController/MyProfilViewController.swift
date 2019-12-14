//
//  MyProfilViewController.swift
//  SneakerApp
//
//  Created by Dung  on 23.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import UserNotifications

class MyProfilViewController: UIViewController {

    func createGradientBackground() {
        let gradientLayer = CAGradientLayer()
              
        gradientLayer.frame = self.view.bounds
        let blau = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
        let pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
        let blau2 = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor

        gradientLayer.colors = [pink,blau,blau2]
              
        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

       }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientBackground()

    }

 
}
