//
//  collectionDetailViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 29.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class collectionDetailViewController: UIViewController {
    @IBOutlet weak var image: UIImageView!
    var collectionImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()

        // Do any additional setup after loading the view.
    }
    
    private func setupImageView(){
        if let detailImage = collectionImage{
            image.image = detailImage
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
