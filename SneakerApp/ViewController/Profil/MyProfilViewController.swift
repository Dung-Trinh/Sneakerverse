//
//  MyProfilViewController.swift
//  SneakerApp
//
//  Created by Dung  on 23.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import UserNotifications
import CoreData

struct savedPhoto {
    var imageName: UIImage!
    var sneakerName: String?
}

class MyProfilViewController: UIViewController {
    
    @IBOutlet weak var myCollection_cv: UICollectionView!
    @IBOutlet weak var switcher: UISegmentedControl!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var feedPreview: UIImageView!
    @IBOutlet weak var myFeeds_view: UIView!
    @IBOutlet var previewGrails:[UIImageView]!
    @IBOutlet var previewCollection:[UIImageView]!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "myCollectionViewCell"
    var myCollection: [savedPhoto] = [savedPhoto(imageName: UIImage(named: "af1")),
                         savedPhoto(imageName: UIImage(named: "af2")),
                         savedPhoto(imageName: UIImage(named: "af3")),
                         savedPhoto(imageName: UIImage(named: "af4")),
                         savedPhoto(imageName: UIImage(named: "af5")),
                         savedPhoto(imageName: UIImage(named: "af5"))]
    var myGrails: [savedPhoto] = [savedPhoto(imageName: UIImage(named: "af1")),
                            savedPhoto(imageName: UIImage(named: "af1")),
                            savedPhoto(imageName: UIImage(named: "af1")),
                            savedPhoto(imageName: UIImage(named: "af1")),
                            savedPhoto(imageName: UIImage(named: "af1")),
                            savedPhoto(imageName: UIImage(named: "af1"))]
    lazy var showCollection : [savedPhoto] = myCollection
    var savedSneaker : [Sneaker]=[]
    var savedBlogpost: [BlogPost]=[]
     var coreDataManager = CoreDataManager()
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){
        
    }
   
    func loadSavedSneakers(){
        self.savedSneaker = coreDataManager.loadSavedSneakers()
   
    }
    func loadSavedBlogposts(){
        self.savedBlogpost = coreDataManager.loadSavedBlogposts()
    }
    

    @IBAction func addSneaker(_ sender: UIButton) {
        performSegue(withIdentifier: "showAddSneaker_Segue", sender: self)

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedSneakers()
        loadSavedBlogposts()
        setupCollectionView()
        setupFeedPreview()
        setupGrailPreview()
        setupCollectionPreview()
        
        let background = BackgroundColor()
        background.createGradientBackground(view: self.view,colors: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MyCollection_Segue"{
            let navVC = segue.destination as? UINavigationController
            
            if let vc = navVC?.viewControllers.first as? MyCollectionViewController{
                vc.items = myCollection
            }
        }
        
        else if segue.identifier == "myFeeds_Segue"{
            if let vc = segue.destination as? FeedTableViewController {
                    vc.blogPosts = savedBlogpost
            }
        }
        
        else if segue.identifier == "myGrails_Segue" {
            if let vc = segue.destination as? MyGrailsCollectionViewController {
                vc.items = savedSneaker
            }
        }
    }
    
    private func setupCollectionView(){
        myCollection_cv.delegate = self
        myCollection_cv.dataSource = self
        
        
        let nib = UINib(nibName: "myCollectionViewCell", bundle: nil)
        myCollection_cv.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    private func setupGrailPreview(){
        var counter = 0
        for preview in previewGrails{
            if counter < savedSneaker.count {
                let url = URL(string: savedSneaker[counter].imageURL)
                    let data = try? Data(contentsOf: url!)
                    
                    if counter == 0 {
                        var tintView = UIView()
                        tintView.backgroundColor = UIColor.init(red: 249/255, green: 241/255, blue: 254/255, alpha: 0.5)
                        tintView.frame = CGRect(x: 0, y: 0, width: preview.frame.width, height: preview.frame.height)
                        preview.addSubview(tintView)
                    }
                    
                    preview.contentMode =  .scaleAspectFill
                    preview.image = UIImage(data: data!)
                    preview.layer.cornerRadius = 8.0
                    preview.layer.masksToBounds = true

                    counter += 1
                    
                }
            
            else {
                //preview.image = UIImage(contentsOfFile: "photo")
                preview.layer.cornerRadius = 8.0
            }
            }
            
    }
    
    private func setupCollectionPreview(){
        var counter = 0
        for preview in previewCollection{
//            let url = URL(string: savedSneaker[counter].imageURL)
//            let data = try? Data(contentsOf: url!)
            
            if counter < myCollection.count {
                if counter == 0 {
                                var tintView = UIView()
                                tintView.backgroundColor = UIColor.init(red: 249/255, green: 241/255, blue: 254/255, alpha: 0.5)
                                tintView.frame = CGRect(x: 0, y: 0, width: preview.frame.width, height: preview.frame.height)
                                preview.addSubview(tintView)
                            }
                            
                            preview.contentMode =  .scaleAspectFill
                            preview.image = myCollection[counter].imageName
                //            preview.image = UIImage(data: data!)
                            preview.layer.cornerRadius = 8.0
                            preview.layer.masksToBounds = true

                            counter += 1
                            
                        }
            else{
                preview.layer.cornerRadius = 8.0
            }
                
            }
            
    }
    
    private func setupFeedPreview() {
        var tintView = UIView()
        tintView.backgroundColor = UIColor.init(red: 43/255, green: 17/255, blue: 187/255, alpha: 0.5)
        tintView.frame = CGRect(x: 0, y: 0, width: feedPreview.frame.width, height: feedPreview.frame.height)
        
        //feedPreview.layer.cornerRadius = 8.0
        feedPreview.addSubview(tintView)
        feedPreview.layer.masksToBounds = true
        
        myFeeds_view.layer.cornerRadius = 15
        myFeeds_view.backgroundColor = UIColor.init(red: 249/250, green: 241/250, blue: 254/250, alpha: 1)
        
        feedButton.setTitle("+\(savedBlogpost.count)", for: .normal)
        
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
