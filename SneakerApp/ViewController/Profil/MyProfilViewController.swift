//
//  MyProfilViewController.swift
//  SneakerApp
//
//  Created by Dung  on 23.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import UserNotifications

struct Item {
    var imageName: UIImage!
}

class MyProfilViewController: UIViewController {

    @IBOutlet weak var myCollection_cv: UICollectionView!
    @IBOutlet weak var myFeeds_cv: UICollectionView!
    @IBOutlet weak var switcher: UISegmentedControl!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "myCollectionViewCell"
    var uploadedImage: Item?
    var myCollection: [Item] = [Item(imageName: UIImage(named: "af1")),
                         Item(imageName: UIImage(named: "af2")),
                         Item(imageName: UIImage(named: "af3")),
                         Item(imageName: UIImage(named: "af4")),
                         Item(imageName: UIImage(named: "af5")),
                         Item(imageName: UIImage(named: "af5"))]
    var myGrails: [Item] = [Item(imageName: UIImage(named: "af1")),
                            Item(imageName: UIImage(named: "af1")),
                            Item(imageName: UIImage(named: "af1")),
                            Item(imageName: UIImage(named: "af1")),
                            Item(imageName: UIImage(named: "af1")),
                            Item(imageName: UIImage(named: "af1"))]
    lazy var showCollection : [Item] = myCollection
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){
        
    }
    

    @IBAction func addSneaker(_ sender: UIButton) {
        performSegue(withIdentifier: "showAddSneaker_Segue", sender: self)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
        let background = BackgroundColor()
        background.createGradientBackground(view: self.view)
        
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var allItems = sender as? [Item]
        
        if segue.identifier == "MyCollection_Segue"{
            let navVC = segue.destination as? UINavigationController
            
            if let vc = navVC?.viewControllers.first as? MyCollectionViewController{
                vc.items = allItems
            }
        }
    }
    
    private func setupCollectionView(){
        myCollection_cv.delegate = self
        myCollection_cv.dataSource = self
        
        myFeeds_cv.delegate = self
        myFeeds_cv.dataSource = self
        
        
        let nib = UINib(nibName: "myCollectionViewCell", bundle: nil)
        myCollection_cv.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        myFeeds_cv.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numberOfItemForRow: CGFloat = 3
            let lineSpacing: CGFloat = 5
            let interItemSpacing: CGFloat = 5
            
            let width = (myCollection_cv.frame.width - (numberOfItemForRow - 1) * interItemSpacing)/numberOfItemForRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.scrollDirection = .vertical
        
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            myCollection_cv.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            myFeeds_cv.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    @IBAction func switchView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0{
            self.showCollection = myCollection
            myCollection_cv.reloadData()
        }
        else if sender.selectedSegmentIndex == 1{
            self.showCollection = myGrails
            myCollection_cv.reloadData()
        }
    }
    
 
}

extension MyProfilViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! myCollectionViewCell
        cell.imageView.image = showCollection[indexPath.item].imageName
        cell.sneakerCount.text = ""
        cell.imageView.alpha = 1

        if(indexPath.row == 5){
            cell.sneakerCount.text = "+\(showCollection.count)"
            cell.sneakerCount.textAlignment = .center
            cell.imageView.alpha = 0.5
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var allItems = showCollection
        if indexPath.row == 5{
            performSegue(withIdentifier: "MyCollection_Segue", sender: allItems)
        }
    }
}
