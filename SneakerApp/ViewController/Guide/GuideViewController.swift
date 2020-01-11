//
//  GuideViewController.swift
//  SneakerApp
//
//  Created by Dung  on 09.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {

    
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var guideCollectionView: UICollectionView!
    var images = [UIImage(named: "galaxy"),UIImage(named: "galaxy"),UIImage(named: "galaxy")]
    
    var titles = ["WELCOME","NEWS","STOCKX INTEGRATION"]
    var titleDescription = ["i","provides you with daily news about new sneaker releases, photos, videos & more.",""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guideCollectionView.dataSource = self
        guideCollectionView.delegate = self
        startBtn.isHidden = true
    }
    


    
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if(scrollView.tag == 0){
//            let center = CGPoint(x: scrollView.contentOffset.x+(scrollView.frame.width/2), y: (scrollView.frame.height/2))
//     }
//    }
        
        
  
    @IBAction func getStarted(_ sender: UIButton) {
        self.performSegue(withIdentifier: "guide_to_mainView", sender: nil)
    }
    
}
extension GuideViewController :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GuideCell", for: indexPath) as? GuideCollectionViewCell
        cell?.updateUI(image: images[indexPath.row]!, title: titles[indexPath.row], text: titleDescription[indexPath.row])
      
        return cell!
    }
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.pageControl.numberOfPages = self.images.count
        return self.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha=0
        UIView.animate(withDuration: 1, animations: {
            cell.alpha=1
        })
        
        cell.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 1) {
            cell.transform = CGAffineTransform.identity
        }
    }
}

extension GuideViewController: UICollectionViewDelegate{

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        pageControl.currentPage = Int(page)
        if(pageControl.currentPage==2){
            self.startBtn.isHidden = false
            var a = CustomAnimator()
            a.buttonScaleAnimation(notificationBtn: startBtn, color: .white)
        }
    }
    

    }
    




