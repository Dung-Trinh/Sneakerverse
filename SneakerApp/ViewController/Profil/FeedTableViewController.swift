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
    let shadowView = UIView()
    var nc = NotificationCenter.default
    var coreDataManager = CoreDataManager()
    
        
        
        
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
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if let indexPaths = myfeeds_tv.indexPathsForVisibleRows {
            for indexPath in indexPaths {
                if let cell = myfeeds_tv?.cellForRow(at: indexPath) as? FeedTableViewCell {
                    cell.isEditing = editing
                    cell.reloadInputViews()
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            coreDataManager.deleteBlogpost(blogPost: blogPosts[indexPath.row])
            self.blogPosts.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.nc.post(name: Notification.Name("reloadFeedNumber"), object: nil)
    }
        
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
              nc.addObserver(self, selector: #selector(reloadItems), name: Notification.Name("reloadFeeds"), object: nil)
            myfeeds_tv.dataSource = self
            myfeeds_tv.delegate = self
            navigationItem.rightBarButtonItem = editButtonItem
      

        }
    
    @objc func reloadItems(){
        self.blogPosts = coreDataManager.loadSavedBlogposts()
        myfeeds_tv.reloadData()
    }
    }


