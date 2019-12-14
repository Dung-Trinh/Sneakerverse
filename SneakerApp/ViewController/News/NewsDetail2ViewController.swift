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

class NewsDetailViewController: UIViewController {
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var navigationBar: UINavigationItem!
    
    
    var imgArray = [UIImage(named: "sneakercon"),UIImage(named: "sneakermesse"),UIImage(named: "sneakermesse2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageCollectionView.dataSource = self
        self.imageCollectionView.delegate = self
        navigationBar.title = "Sneakercon"
        loadYoutube(videoID: "QuyO_-LA-YU")
    }
    
    func loadYoutube(videoID:String) {
        guard let youtubeURL = URL(string: "https://www.youtube.com/embed/\(videoID)") else {
            return
        }
        webView.load(URLRequest(url: youtubeURL))
    }
    
    func genarateThumbnailFromYouTubeID(youTubeID: String) {
          let urlString = "http://img.youtube.com/vi/\(youTubeID)/1.jpg"
          let image = try! (UIImage(withContentsOfUrl: urlString))!
      }
    
    func getThumbnailFromVideoUrl(urlString: String) {
        DispatchQueue.global().async {
            let asset = AVAsset(url: URL(string: urlString)!)
            let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
            assetImgGenerate.appliesPreferredTrackTransform = true
            let time = CMTimeMake(value: 1, timescale: 20)
            let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
            if img != nil {
                let frameImg  = UIImage(cgImage: img!)
                DispatchQueue.main.async(execute: {
                    // assign your image to UIImageView
                })
            }
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
