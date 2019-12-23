//
//  NewsDetail2ViewController.swift
//  SneakerApp
//
//  Created by Dung  on 13.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import WebKit
import AVKit
import EventKit

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    var background = BackgroundColor()
    var blogPost : BlogPost?
    
    var imgArray : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        background.createGradientBackground(view: self.view)
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        updateUI()
        //navigationBar.title = "Sneakercon"
        //YoutubeVideoPlayer(videoID: "QMUsqxF_AZk", webView: self.webView)
    }
    
    //MARK:- Set the Content of the View
    func updateUI(){
        navigationBar.title = blogPost?.title
        textView.text = blogPost?.description
        YoutubeVideoPlayer(videoID: blogPost!.contentVideo, webView: self.webView)
        
        let url = URL(string: blogPost!.cover)
        let data = try? Data(contentsOf: url!)
        imgArray.insert(UIImage(data: data!)!, at: 0)
        
        for i in blogPost!.contentPictures{
            let url = URL(string: i)
             // TODO: try catch einbauen !
            let data = try? Data(contentsOf: url!)
            imgArray.append(UIImage(data: data!)!)
        }
    }

    
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
        
    }
    @IBAction func sharePost(_ sender: Any) {
        let text = "my demo text"
          let URL:NSURL = NSURL(string:"https://stockx.com/de-de/")!
          let image = UIImage(named: "j1.png")
          let vc = UIActivityViewController(activityItems:[ text,URL], applicationActivities: [])
          if let popoverController = vc.popoverPresentationController{
              popoverPresentationController!.sourceView = self.view
              popoverPresentationController!.sourceRect = self.view.bounds
              
          }
          self.present(vc,animated: true, completion: nil)
    }

    @IBAction func calenderReminder(_ sender: UIButton) {
        let eventStore:EKEventStore = EKEventStore()

        eventStore.requestAccess(to: .event) { (granted,error) in
            if(granted) && (error == nil)
            {
                print("\n granted: \(granted)\n")

           
        
        let event:EKEvent = EKEvent(eventStore:eventStore)
        event.title = "Jordan 1 Calender Notification"
        event.startDate = Date()
        event.endDate = Date()
        event.notes = "this is a note"
        event.calendar = eventStore.defaultCalendarForNewEvents
        do{
            try eventStore.save(event, span: .thisEvent)
        }catch let error as NSError{
            print("Fehler1 NSERROR: \(error)")
            return
        }
            }
        }
        var message = ToastMessage(message: "Der Release ist in deinem Kalender vermerkt! ✅", view: self.view)
    }
    
}


extension NewsDetailViewController :UICollectionViewDataSource,UICollectionViewDelegate{
    ///create a certain number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    ///make the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell2", for: indexPath) as? BlogPostCollectionViewCell

        cell?.img.image = imgArray[indexPath.row]
        return cell!
    }
    
    
}

extension NewsDetailViewController : UICollectionViewDelegateFlowLayout{
    ///set size of the specified  item's cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    ///spacing between the successive items in the row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

