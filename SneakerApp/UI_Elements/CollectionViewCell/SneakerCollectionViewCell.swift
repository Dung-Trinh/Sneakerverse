//
//  SneakerCollectionViewCell.swift
//  SneakerApp
//
//  Created by Dung  on 30.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class SneakerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var backgroundLayer: UIView!
    @IBOutlet weak var title: UILabel!
    
    var sneaker: Sneaker!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        
        if let sneaker = sneaker{
            img.image = sneaker.img
            title.text = sneaker.titel
            
        }
        
        backgroundLayer.layer.cornerRadius = 10
        backgroundLayer.layer.masksToBounds = true
    }
}
