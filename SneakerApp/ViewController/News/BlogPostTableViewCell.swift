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
    @IBOutlet weak var backgroundLayer: UIView!
    @IBOutlet weak var Imagetext: UILabel!
    @IBOutlet weak var textBox: UIView!
    @IBOutlet weak var title: UILabel!
    
    var modell : BlogPost?{
        didSet{
            updateUI()
        }
    }
    
    func updateUI(){
        self.layer.masksToBounds = false
        loadImage(url: modell!.cover)
        Imagetext.text = modell?.description
        title.text = modell?.title
    }
    
    func loadImage(url:String) {
        if(url == nil){
            img.image = UIImage(named: "error_img")
        }else{
        img.load(url: NSURL(string: url) as! URL)
        }
        //img.layer.cornerRadius = 40
        //img.clipsToBounds = true
        
        
        self.layer.cornerRadius = 30
        self.textBox.layer.cornerRadius = 30
        self.layer.masksToBounds = true


        //backgroundLayer.layer.cornerRadius = 40
        //backgroundLayer.clipsToBounds = true
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
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
