//
//  ViewController.swift
//  SneakerApp
//
//  Created by Dung  on 19.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import TinyConstraints
import Gifu

class CalenderViewController: UIViewController {
    @IBOutlet weak var adidasView: UIView!
    @IBOutlet weak var pumaView: UIView!
    @IBOutlet weak var nikeView: UIView!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    
    var gradientLayer: CAGradientLayer!

    var loadingGif: UIView = {
        let view = GIFImageView()
        view.contentMode = .scaleAspectFit
        view.animate(withGIFNamed: "nike")
        return view
    }()
    
    var imageView: UIImageView={
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    func setupViews(){
        view.addSubview(imageView)
        view.backgroundColor = .black
        view.addSubview(loadingGif)
        loadingGif.centerInSuperview()
        loadingGif.width(view.frame.width)
        loadingGif.height(view.frame.width)
        loadingGif.leftToSuperview()
        loadingGif.rightToSuperview()
        
        imageView.centerXToSuperview()
        imageView.topToSuperview(offset: 36, usingSafeArea: true)
        imageView.width(150)
        imageView.height(150)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradientBackground()
        adidasView.alpha = 0
        pumaView.alpha = 0

    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            nikeView.alpha = 1
            adidasView.alpha = 0
            pumaView.alpha = 0
            
        }else if(sender.selectedSegmentIndex == 1 ){
            nikeView.alpha = 0
            adidasView.alpha = 1
            pumaView.alpha = 0
        }else {
            nikeView.alpha = 0
            adidasView.alpha = 0
            pumaView.alpha = 1
        }
    }
    

    func createGradientBackground() {
        gradientLayer = CAGradientLayer()
     
        gradientLayer.frame = self.view.bounds
        let blau = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor
        let pink = UIColor(red:0.72, green:0.31, blue:0.59, alpha:1.0).cgColor
        let blau2 = UIColor(red:0.24, green:0.28, blue:0.50, alpha:1.0).cgColor

        gradientLayer.colors = [pink,blau,blau2]
     
        self.view.layer.addSublayer(gradientLayer)
        self.view.layer.insertSublayer(gradientLayer, at: 0)

    }
}


