//
//  FeedTableViewCell.swift
//  SneakerApp
//
//  Created by Frank Pham on 24.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    
    @IBOutlet weak var feedImage: UIImageView!
    
    @IBOutlet weak var feedLabel: UILabel!
    
    let tintView = UIView()
    
    
    var item: BlogPost!{
        didSet {
            updateUI()
        }
    }
    
    func updateUI(){
        
        let url = URL(string:item!.cover)
        let data = try? Data(contentsOf: url!)
        
        feedImage.image = UIImage(data: data!)
        feedLabel.text = item.title
        feedImage.layer.cornerRadius = 8.0
        
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        tintView.backgroundColor = UIColor.init(red: 43/255.0, green: 17/255.0, blue: 187/255.0, alpha: 0.6)
        tintView.frame = CGRect(x: 0, y: 0, width: feedImage.frame.width, height: feedImage.frame.height)

        feedImage.addSubview(tintView)
        feedImage.layer.masksToBounds = true
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
