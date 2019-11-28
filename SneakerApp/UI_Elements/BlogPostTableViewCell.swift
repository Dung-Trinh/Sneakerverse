//
//  BlogPostTableViewCell.swift
//  SneakerApp
//
//  Created by Dung  on 23.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class BlogPostTableViewCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    var modell : BlogPost?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        self.title.text = modell?.title
        loadImage(url: modell!.imageURL)
    }
    
    func loadImage(url:String) {
            let imageURL = URL(string: url)!
        img.kf.indicatorType = .activity
        img.kf.setImage(with: imageURL)
        img.layer.cornerRadius = 40
        img.clipsToBounds = true

        
        }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
