//
//  myGrailsCollectionViewCell.swift
//  SneakerApp
//
//  Created by Frank Pham on 26.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class myGrailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var blur_effect: UIVisualEffectView!
    @IBOutlet weak var grailImage: UIImageView!
    @IBOutlet weak var sneakerName: UILabel!
    
    var grail: Sneaker! {
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        
        let url = URL(string: grail!.imageURL)
        let data = try? Data(contentsOf: url!)
        
        grailImage.image = UIImage(data: data!)
        sneakerName.text = grail.title
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
