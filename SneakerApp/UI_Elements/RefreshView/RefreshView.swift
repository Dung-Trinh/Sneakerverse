//
//  RefreshView.swift
//  SneakerApp
//
//  Created by Dung  on 23.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import Foundation
import UIKit

class RefreshView:UIView{
    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    var gradientView: UIView!
    @IBOutlet weak var loading_label: UILabel!
    @IBOutlet weak var loadingView: UIView!
    
}
extension RefreshView {
    
    fileprivate func initializeGradientView() {
        gradientView = UIView(frame: CGRect(x: -30, y: 0, width: 100, height: 60))
        logo.addSubview(gradientView)
        
        
        gradientView.backgroundColor = UIColor.clear
    }
    
    func startAnimation() {
//        UIView.animate(withDuration: 0.5, delay: 0.0, options: [.autoreverse, .repeat], animations: {
//            self.gradientView.frame.origin.x = 100
//            self.logo.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
//            UIView.animate(withDuration: 0.6) {
//                self.logo.transform = CGAffineTransform.identity
//            }
//        }, completion: nil)

        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
                        
  

                        self.loadingView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                    

                     
                            self.loadingView.transform = CGAffineTransform.identity
                            
            


        }, completion: nil)
    }
    
    func stopAnimation() {
        loadingView.layer.removeAllAnimations()

    }
    
    
}
