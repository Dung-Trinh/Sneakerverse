//
//  BackgroundColor.swift
//  SneakerApp
//
//  Created by Dung  on 14.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class BackgroundColor{
    var gradientLayer: CAGradientLayer!
    let blau = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
    let pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
    let blau2 = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
    
    func createGradientBackground(view:UIView,colors:[UIColor]?) {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = view.bounds
        if colors == nil{
        gradientLayer.colors = [pink,blau,blau2]
        }else{
            //cast color in cg color
            var cg_colors : [CGColor] = []
            for i in colors!{
                cg_colors.append(i.cgColor)
            }
            gradientLayer.colors = cg_colors

        }
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "space")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImage.alpha = 0.2
        view.insertSubview(backgroundImage, at: 0)


        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        view.layer.insertSublayer(gradientLayer, at: 0)

    }
    

}
