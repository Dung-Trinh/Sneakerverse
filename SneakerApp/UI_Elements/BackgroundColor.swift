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
//    let blau = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
//    let pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
//    let blau2 = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
    
    let blau = UIColor(red:132/255, green:0/255, blue:255/255, alpha:1.0).cgColor
    //let pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
    let pink = UIColor(red:80/255, green:48/255, blue:187/255, alpha:1.0).cgColor
    let blau2 = UIColor(red:211/255, green:88/255, blue:245/255, alpha:1.0).cgColor
    
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
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        backgroundImage.alpha = 0.2
        view.insertSubview(backgroundImage, at: 0)


        gradientLayer.frame = view.bounds
        view.layer.addSublayer(gradientLayer)
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func createGradient_v2(view :UIView){
        let layer = CAGradientLayer()
        layer.frame=view.bounds
        let c1 = UIColor(red:0.32, green:0.47, blue:0.98, alpha:1.0).cgColor
        let c2 = UIColor(red:0.66, green:0.25, blue:0.63, alpha:1.0).cgColor
        layer.colors =
            [c2,c1]
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.startPoint = CGPoint(x: 0, y: 0.4)
        view.layer.addSublayer(layer)
        view.layer.insertSublayer(layer, at: 0)


    }
}
