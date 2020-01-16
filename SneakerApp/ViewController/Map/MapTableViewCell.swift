//
//  MapTableViewCell.swift
//  SneakerApp
//
//  Created by Dung  on 14.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class MapTableViewCell: UITableViewCell {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    var modell : MapLocation?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        title.text = modell?.name
        img.image = UIImage(named: modell?.logoName ?? "error_img")
        address.text = modell?.address
    }
}
