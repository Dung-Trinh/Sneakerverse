//
//  FeedTableViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 25.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController {
     @IBOutlet weak var myfeeds_tv: UITableView!
        
    var blogPosts : [BlogPost] = []

        var myCollection: [savedPhoto] = [savedPhoto(imageName: UIImage(named: "af1")),
                                    savedPhoto(imageName: UIImage(named: "af2")),
                                    savedPhoto(imageName: UIImage(named: "af3")),
                                    savedPhoto(imageName: UIImage(named: "af4")),
                                    savedPhoto(imageName: UIImage(named: "af5")),
                                    savedPhoto(imageName: UIImage(named: "af5"))]
        
    //    @IBOutlet weak var headerLabel: UILabel!
                
        let shadowView = UIView()
        
        
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "feeds", for: indexPath) as! FeedTableViewCell
            let feed = blogPosts[indexPath.row]
            cell.item = feed

            return cell
        }
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return blogPosts.count
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            print("Select row \(indexPath.row)")
        }
        
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            let rotationTransform = CATransform3DTranslate(CATransform3DIdentity, 0, -100, -50)
            cell.layer.transform = rotationTransform
            cell.alpha = 0.5

            UIView.animate(withDuration: 0.8) {
                cell.layer.transform = CATransform3DIdentity
                cell.alpha = 1.0
            }




        }
   
        
        func setupShadow(frame: UIImageView!) -> UIView! {
            shadowView.frame = CGRect(x: 0, y: 0, width: frame.frame.width, height: frame.frame.height)
            shadowView.layer.masksToBounds = false
            shadowView.layer.shadowRadius = 10
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
            shadowView.layer.shadowOpacity = 0.5
            
            shadowView.layer.shadowPath = UIBezierPath(rect: frame.bounds).cgPath
            shadowView.layer.shouldRasterize = true
            
            return shadowView
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? NewsDetailViewController, let cell = sender as? FeedTableViewCell, let indexPath = myfeeds_tv.indexPath(for: cell){
         dest.blogPost = blogPosts[indexPath.row]
     }
    }
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            myfeeds_tv.dataSource = self
            myfeeds_tv.delegate = self
      

        }
        

        

    }
