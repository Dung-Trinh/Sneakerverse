//
//  CustomActivityIndicator.swift
//  SneakerApp
//
//  Created by Dung  on 17.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import Foundation
import UIKit
class CustomActivityIndicator {
    let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
    let container: UIView = UIView()
    let loadingView: UIView = UIView()
    
    func showLoadingScreen(superview: UIView){

        container.backgroundColor = UIColor(red:0.47, green:0.47, blue:0.47, alpha:0.2)
           container.frame = superview.frame
           container.center = superview.center

        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = superview.center
        loadingView.backgroundColor = UIColor.darkGray
           loadingView.clipsToBounds = true
           loadingView.layer.cornerRadius = 10

        //let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.color = UIColor.white
        //actInd.frame = CGRectMake(0.0, 0.0, 40.0, 40.0)
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        //actInd.activityIndicatorViewStyle = UIActivityIndicatorView.Style.UIActivityIndicatorView.Style.large
         //actInd.center = CGPointMake(loadingView.frame.size.width / 2,loadingView.frame.size.height / 2)
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y:  loadingView.frame.size.height / 2)
           loadingView.addSubview(actInd)
           container.addSubview(loadingView)
           superview.addSubview(container)
           actInd.startAnimating()
    }
    
    func stopAnimation(uiView: UIView){
        container.removeFromSuperview()
        actInd.stopAnimating()
    }
}
