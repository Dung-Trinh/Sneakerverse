//
//  ToastMessage.swift
//  SneakerApp
//
//  Created by Dung  on 15.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class ToastMessage{
    init(message: String,view:UIView) {
        showText(message: message, view: view)
    }
    
    func showText(message: String,view:UIView) {
        let textLabel = UILabel(frame: CGRect(x: 0, y: view.frame.maxY, width: view.frame.width-80, height: 40))
        textLabel.center = view.center
        textLabel.center.x = view.center.x
        textLabel.frame.origin.y=view.frame.maxY
        textLabel.font = UIFont.systemFont(ofSize: 13)
        textLabel.textAlignment = .center
        textLabel.backgroundColor = UIColor.darkGray
        textLabel.textColor = UIColor.white
        textLabel.layer.cornerRadius = 5
        textLabel.clipsToBounds = true
        textLabel.text = message
        view.addSubview(textLabel)
        
        UIView.animate(withDuration: 0.6,delay: 0,options: .curveEaseInOut, animations: {
            textLabel.frame = CGRect(x: textLabel.frame.origin.x, y: textLabel.frame.origin.y - 130, width: textLabel.frame.width, height: textLabel.frame.height)
        })
        
    
        UIView.animate(withDuration: 0.8, delay: 2, options: .curveEaseInOut, animations: {
            textLabel.alpha = 0.0
        }) {(isCompleted) in
            textLabel.removeFromSuperview()
            
        }
      
    }
}
