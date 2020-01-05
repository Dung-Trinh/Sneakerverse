//
//  CustomAnimator.swift
//  SneakerApp
//
//  Created by Dung  on 26.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import UIKit
class CustomAnimator{
    
    func buttonScaleAnimation(notificationBtn:UIButton,color:UIColor){
        notificationBtn.tintColor = color
        UIView.animate(withDuration: 0.4,delay: 0,options: .curveEaseIn, animations: {
           notificationBtn.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.4,delay: 0,options:.curveEaseOut , animations: {
                notificationBtn.transform = CGAffineTransform.identity
            })
                })
    }
}
