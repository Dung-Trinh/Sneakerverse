//
//  MyCollectionViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 22.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController{
    var selectedImage: savedPhoto?
    var selectedIndexPath: IndexPath!
    var items: [savedPhoto]!
    let cellIdentifier = "myCollectionViewCell"
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    @IBOutlet weak var myCollection_cv: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CollectionDetail_Segue" {
            let item = sender as! savedPhoto
            if let vc = segue.destination as? collectionDetailViewController{
                vc.collectionImage = item.imageName
            }
        }
    }
    
    

   private func setupCollectionView(){
            myCollection_cv.delegate = self
            myCollection_cv.dataSource = self
            let nib = UINib(nibName: "myCollectionViewCell", bundle: nil)
            myCollection_cv.register(nib, forCellWithReuseIdentifier: cellIdentifier)
            
        }
        
    @IBAction func backButton(_ sender: Any) {
    }
    override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            setupCollectionViewItemSize()
        }
        
        private func setupCollectionViewItemSize() {
            if collectionViewFlowLayout == nil {
                let numberOfItemForRow: CGFloat = 2
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

     
    }


extension MyCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return items.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! myCollectionViewCell
            
            cell.sneakerName.text = items[indexPath.item].sneakerName
            cell.sneakerName.center = self.view.center
            cell.imageView.image = items[indexPath.item].imageName

            return cell
            
        }
        
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            selectedImage = items[indexPath.item]
            self.selectedIndexPath = indexPath
            
            self.performSegue(withIdentifier: "CollectionDetail_Segue", sender: selectedImage)
            }
        
        
    }


extension MyCollectionViewController : ZoomingViewController{
    func zoomingBackgroundView(for transition: PopAnimator) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: PopAnimator) -> UIImageView? {
        if let indexPath = selectedIndexPath{
            let cell = myCollection_cv?.cellForItem(at: indexPath) as! myCollectionViewCell
            return cell.imageView
        }
        
        return nil
        
    }
}
