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
    @IBOutlet weak var feedButton: UIButton!
    @IBOutlet weak var feedPreview: UIImageView!
    @IBOutlet weak var myFeeds_view: UIView!
    @IBOutlet var previewGrails:[UIImageView]!
    @IBOutlet var previewCollection:[UIImageView]!
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    let cellIdentifier = "myCollectionViewCell"
    var myCollection: [savedPhoto] =
        [savedPhoto(picture: UIImage(named: "af1"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af2"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af3"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af4"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af5"),sneakerName: "testi1"),
        savedPhoto(picture: UIImage(named: "af5"),sneakerName: "testi1")]
    
    var savedSneaker : [Sneaker]=[]
    var savedBlogpost: [BlogPost]=[]
    var savedCollection: [savedPhoto]=[]
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
                            preview.image = myCollection[counter].picture
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
        let tintView = UIView()
        tintView.backgroundColor = UIColor.init(red: 43/255, green: 17/255, blue: 187/255, alpha: 0.5)
        tintView.frame = CGRect(x: 0, y: 0, width: feedPreview.frame.width, height: feedPreview.frame.height)
        
        //feedPreview.layer.cornerRadius = 8.0
        feedPreview.addSubview(tintView)
        feedPreview.layer.masksToBounds = true
        
        myFeeds_view.layer.cornerRadius = 15
        myFeeds_view.backgroundColor = UIColor.init(red: 249/250, green: 241/250, blue: 254/250, alpha: 1)
        
        feedButton.setTitle("+\(savedBlogpost.count)", for: .normal)
        
    }
    
   }


