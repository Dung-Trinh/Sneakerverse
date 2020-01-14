//
//  LastPageViewController.swift
//  SneakerApp
//
//  Created by Dung  on 13.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class LastPageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func startBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "toMainView", sender: nil)
    }
    
}
