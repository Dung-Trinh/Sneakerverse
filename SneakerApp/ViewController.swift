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

class ViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

    }


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
}

