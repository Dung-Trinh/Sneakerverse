//
//  GuideCollectionViewCell.swift
//  SneakerApp
//
//  Created by Dung  on 09.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class GuideCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textLabel: UILabel!
    
    func updateUI(image:UIImage,title:String,text:String){
        self.img.image = image
        self.textLabel.text = title
        self.textView.text = text
    }
}
