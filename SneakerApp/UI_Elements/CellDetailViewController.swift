//
//  CellDetailViewController.swift
//  SneakerApp
//
//  Created by Dung  on 28.11.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class CellDetailViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var imgArray = [UIImage(named: "sneakercon"),UIImage(named: "sneakermesse"),UIImage(named: "sneakermesse2")]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }
    override func didReceiveMemoryWarning() {
         super.didReceiveMemoryWarning()
         // Dispose of any resources that can be recreated.
     }
    
    @IBAction func shareBtn(_ sender: Any) {
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


extension CellDetailViewController :UICollectionViewDataSource,UICollectionViewDelegate{
    ///create a certain number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    ///make the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? BlogPostCollectionViewCell

        cell?.img.image = imgArray[indexPath.row]
        return cell!
    }
    
    
}

extension CellDetailViewController : UICollectionViewDelegateFlowLayout{
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
