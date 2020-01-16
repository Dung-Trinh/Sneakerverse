//
//  RoundButton.swift
//  SneakerApp
//
//  Created by Dung  on 22.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
class RoundButton: UIButton {
    
    /// The attribute for the radius of the corner
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            setRadius(value: cornerRadius)
        }
    }
    
    /// Set the radius of the corner
    func setRadius(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    /// The attribute for the colour
    @IBInspectable var bgColor: UIColor = UIColor.init(red: 0, green: 122/255, blue: 255/255, alpha: 1) {
          didSet {
              refreshColor(color: bgColor)
          }
      }
    
    /// Set the background(bg) color
    func refreshColor(color: UIColor) {
        let size: CGSize = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0) // create 1x1 px img
        color.setFill() // set color for the any following  draw operation
        UIRectFill(CGRect(x: 0, y: 0, width: size.width, height: size.height)) // paint the rectangle with the set color
        let bgImage: UIImage = (UIGraphicsGetImageFromCurrentImageContext() as UIImage? ?? nil)!
        UIGraphicsEndImageContext()
        setBackgroundImage(bgImage, for: UIControl.State.normal) // set the background image of the button to the colored 1x1 px img
        clipsToBounds = true // to make the corners round
    }
    /// Initialize the button
    override init(frame: CGRect) {
        super.init(frame: frame);
        createButton()
    }
        
    /// create button for Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createButton()
        }
    /// rendering button
    override func prepareForInterfaceBuilder() {
        createButton()
        }
    
    /// Set the radius, the background colour and the font colour
    func createButton() {
        setRadius(value: cornerRadius)
        refreshColor(color: bgColor)
        self.tintColor = UIColor.white
        }
    }
