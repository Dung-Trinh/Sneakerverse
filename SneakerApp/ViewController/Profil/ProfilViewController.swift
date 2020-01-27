//
//  ProfilViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 23.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class ProfilViewController: UIViewController {

    
    @IBOutlet var previewImages:[UIImageView]!
    
    var myCollection: [savedPhoto] = [savedPhoto(imageName: UIImage(named: "af1")),
    savedPhoto(imageName: UIImage(named: "af2")),
    savedPhoto(imageName: UIImage(named: "af3")),
    savedPhoto(imageName: UIImage(named: "af4")),
    savedPhoto(imageName: UIImage(named: "af5")),
    savedPhoto(imageName: UIImage(named: "af5"))]
    
    let shadowView = UIView()
    
    
    func setupCollection(){
        var counter = 0
        for preview in previewImages{
            preview.contentMode =  .scaleAspectFill
            preview.image = myCollection[counter].imageName
            preview.layer.cornerRadius = 8.0
            preview.layer.masksToBounds = true
            preview.layer.shouldRasterize = true
            //let shadow = setupShadow(frame: preview)
            counter+=1
            
        }
    }
    
    func setupShadow(frame: UIImageView!) -> UIView! {
        shadowView.frame = CGRect(x: 0, y: 0, width: frame.frame.width, height: frame.frame.height)
        shadowView.layer.masksToBounds = false
        shadowView.layer.shadowRadius = 10
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
        shadowView.layer.shadowOpacity = 0.5
        
        shadowView.layer.shadowPath = UIBezierPath(rect: frame.bounds).cgPath
        shadowView.layer.shouldRasterize = true
        
        return shadowView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        

    }
    

    

}
