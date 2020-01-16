//
//  GuideViewController.swift
//  SneakerApp
//
//  Created by Dung  on 09.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    @IBOutlet weak var onboardingContainer: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }

}



