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
    @IBOutlet weak var switcher: UISegmentedControl!
    @IBOutlet weak var calenderTop: UICollectionView!
    @IBOutlet weak var calenderBottom: UICollectionView!
    var allSneaker : [Sneaker] = []
    var showSneakerList : [Sneaker] = []

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
        calenderTop.dataSource = self
        calenderTop.delegate = self
        
        calenderBottom.dataSource = self
        calenderBottom.delegate = self
        allSneaker.append(Sneaker(title: "Nike schuh", date: "12.12", img: UIImage(named: "j1")!,brand:"Nike"))
        
        allSneaker.append(Sneaker(title: "adidas schuh", date: "12.12", img: UIImage(named: "y1")!,brand:"Adidas"))
        allSneaker.append(Sneaker(title: "puma schuh", date: "12.12", img: UIImage(named: "p1")!,brand:"Puma"))
        
        self.showSneakerList=allSneaker

    }

    @IBAction func switchViews(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.showSneakerList = allSneaker;
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 1{
            self.showSneakerList=allSneaker.filter{$0.brand == "Nike"}
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 2{
            self.showSneakerList=allSneaker.filter{$0.brand == "Adidas"
            }
            calenderTop.reloadData()
            calenderBottom.reloadData()
        }
        else if sender.selectedSegmentIndex == 3{
            self.showSneakerList=allSneaker.filter{$0.brand == "Puma"}
            calenderTop.reloadData()
            calenderBottom.reloadData()
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


extension CalenderViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        showSneakerList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SneakerCell", for: indexPath) as! SneakerCollectionViewCell
        cell.sneaker = showSneakerList[indexPath.row]
        return cell
    }
    
    
    
}
extension CalenderViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SneakerDetailViewController") as? SneakerDetailViewController
        /// push the DetailViewController on the stack
        self.navigationController?.pushViewController(vc!,animated:true)
    }
}

