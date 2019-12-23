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

}
extension RefreshView {
    
    fileprivate func initializeGradientView() {
        gradientView = UIView(frame: CGRect(x: -30, y: 0, width: 100, height: 60))
        logo.addSubview(gradientView)
        gradientView.layer.insertSublayer(gradientColor(frame: gradientView.bounds), at: 0)
        gradientView.backgroundColor = UIColor.clear
    }
    
    fileprivate func gradientColor(frame: CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.5)
        layer.endPoint = CGPoint(x: 0, y: 0.5)
        layer.colors = [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.withAlphaComponent(0.7).cgColor, UIColor.white.withAlphaComponent(0).cgColor]
        return layer
    }
    
    func startAnimation() {
        initializeGradientView()
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.autoreverse, .repeat], animations: {
            self.gradientView.frame.origin.x = 100
        }, completion: nil)
    }
    
    func stopAnimation() {
        gradientView.layer.removeAllAnimations()
        gradientView = nil
    }
}
