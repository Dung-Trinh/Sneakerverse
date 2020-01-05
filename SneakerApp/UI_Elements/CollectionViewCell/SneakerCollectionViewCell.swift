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
    @IBOutlet weak var date: UILabel!
    
    var sneaker: Sneaker!{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        let url = URL(string: sneaker.imageURL)
         // TODO: try catch einbauen !
        let data = try? Data(contentsOf: url!)
            img.image = UIImage(data: data!)
            title.text = sneaker.title
        
        let array : [String]?
        if sneaker.releaseDate.contains("."){
            array = sneaker.releaseDate.components(separatedBy: ".")
        }else{
            array = sneaker.releaseDate.components(separatedBy: "/")
        }
        date.text = array?[1]
        
        backgroundLayer.layer.cornerRadius = 10
        backgroundLayer.layer.masksToBounds = true
    }
}
