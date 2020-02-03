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

class MyProfilViewController: UIViewController {
    
    @IBOutlet weak var myCollection_cv: UICollectionView!
    @IBOutlet weak var myGrails_cv: UICollectionView!
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var feedPreview: UIImageView!
    @IBOutlet weak var myFeeds_view: UIView!
    
    lazy var xAchse: CGFloat = myCollection_cv.frame.width/8
    lazy var yAchse: CGFloat = myCollection_cv.frame.height/8
    
    lazy var xGrailAchse: CGFloat = myGrails_cv.frame.width/8
    lazy var yGrailAchse: CGFloat = myGrails_cv.frame.height/8
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "myCollectionViewCell"
    let grailIdentifier = "myGrailsCollectionViewCell"
    var myCollection: [savedPhoto] =
        [savedPhoto(picture: UIImage(named: "af1"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af2"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af3"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af4"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af5"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af5"),sneakerName: "testi1")]
    
    var savedSneaker : [Sneaker]=[]
    var savedBlogpost: [BlogPost]=[]
    var savedCollection: [savedPhoto]?=[]
    var coreDataManager = CoreDataManager()
    var counter = 0
    
    @IBAction func unwindToProfile(_ sender: UIStoryboardSegue){
        
    }
   
    @IBAction func reloadData(_ sender: Any) {
        loadSavedSneakers()
        loadSavedBlogposts()
        loadSavedCollection()
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
    func loadSavedCollection(){
        savedCollection = coreDataManager.loadSavedCollection()
    }
    
    func deleteCollection(){
        coreDataManager.deleteEntireCollection()
    }
    func saveTestColletion(){
        for en in myCollection{
            coreDataManager.saveCollectionPhoto(collectionPhoto: en)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSavedSneakers()
        loadSavedBlogposts()
        saveTestColletion()
        loadSavedCollection()
        deleteCollection()
        setupCollectionView()
        setupCollectionViewItemSize()
        setupFeedPreview()
        
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
        
        
        myCollection_cv.dataSource = self
        myCollection_cv.delegate = self
        
        myGrails_cv.dataSource = self
        myGrails_cv.dataSource = self
        
        
        let nib = UINib(nibName: "myCollectionViewCell", bundle: nil)
        myCollection_cv.register(nib, forCellWithReuseIdentifier: cellIdentifier)
        
        let grailNib = UINib(nibName: "myGrailsCollectionViewCell", bundle: nil)
        myGrails_cv.register(grailNib, forCellWithReuseIdentifier: grailIdentifier)
    }
    
    
    
    private func setupCollectionViewItemSize(){
        if collectionViewFlowLayout == nil {
            let numberOfItemForRow: CGFloat = 2
            let lineSpacing: CGFloat = 0
            let interItemSpacing: CGFloat = 0
            
            let width = myCollection_cv.frame.width/numberOfItemForRow
            let height = width
            
            myCollection_cv.isScrollEnabled = false
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            
            
            collectionViewFlowLayout.itemSize = CGSize(width: 125, height: 125)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
            
            myCollection_cv.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            myGrails_cv.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
            
       }
    }
    
    
    private func setupFeedPreview() {
        let tintView = UIView()
        tintView.backgroundColor = UIColor.init(red: 43/255, green: 17/255, blue: 187/255, alpha: 0.5)
        tintView.frame = CGRect(x: 0, y: 0, width: feedPreview.frame.width, height: feedPreview.frame.height)
        tintView.translatesAutoresizingMaskIntoConstraints = false
        
        //feedPreview.layer.cornerRadius = 8.0
        feedPreview.addSubview(tintView)
        feedPreview.layer.masksToBounds = true
        tintView.leftAnchor.constraint(equalTo: feedPreview.leftAnchor).isActive = true
        tintView.rightAnchor.constraint(equalTo: feedPreview.rightAnchor).isActive = true
        tintView.bottomAnchor.constraint(equalTo: feedPreview.bottomAnchor).isActive = true
        tintView.topAnchor.constraint(equalTo: feedPreview.topAnchor).isActive = true
        tintView.widthAnchor.constraint(equalTo: feedPreview.widthAnchor).isActive = true
        tintView.heightAnchor.constraint(equalTo: feedPreview.heightAnchor).isActive = true
        
        myFeeds_view.layer.cornerRadius = 15
        myFeeds_view.backgroundColor = UIColor.init(red: 249/250, green: 241/250, blue: 254/250, alpha: 1)
        
        feedButton.setTitle("+\(savedBlogpost.count)", for: .normal)
        
    }
    
   }

extension MyProfilViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.myCollection_cv{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! myCollectionViewCell
            
            if let collectionImage = myCollection[indexPath.row].picture{
                cell.imageView.image = collectionImage
                cell.imageView.clipsToBounds = true
                
                cell.frame = CGRect(x: xAchse, y: yAchse, width: cell.frame.width, height: cell.frame.height)
                cell.layer.cornerRadius = 8
                xAchse += 10
                yAchse += 10
                
            }
            
            else{
                cell.imageView.image = UIImage(named: "photo.fill")
            }
            
            
            return cell
            
        }
        
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: grailIdentifier, for: indexPath) as! myGrailsCollectionViewCell
            
            if indexPath.row < savedSneaker.count{
                let grail = savedSneaker[indexPath.row]
                cell.grail = grail
                cell.sneakerName.text = ""
                cell.backgroundColor = UIColor.init(red: 249/255, green: 241/255, blue: 254/255, alpha: 1)
                cell.frame = CGRect(x: xGrailAchse, y: yGrailAchse, width: cell.frame.width, height: cell.frame.height)
                cell.layer.cornerRadius = 8
                xGrailAchse += 10
                yGrailAchse += 10
                
            }
            
            
            else{
                cell.grailImage.image = UIImage(named: "af2")
                cell.grailImage.contentMode = .scaleAspectFill
                cell.frame = CGRect(x: xGrailAchse, y: yGrailAchse, width: cell.frame.width, height: cell.frame.height)
                cell.sneakerName.text = ""
                cell.layer.cornerRadius = 8
                xGrailAchse += 10
                yGrailAchse += 10
            }
            
            
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath)
        
        if collectionView == self.myCollection_cv{
            if indexPath.row == 2 {
                performSegue(withIdentifier: "MyCollection_Segue", sender: self)
            }
        }
        
        else{
                performSegue(withIdentifier: "myGrails_Segue", sender: self)
        }
        
    }
}


