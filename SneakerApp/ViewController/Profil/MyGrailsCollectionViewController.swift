//
//  MyGrailsCollectionViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 26.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit


class MyGrailsCollectionViewController: UIViewController{

    var selectedSneaker: Sneaker?
        var items: [Sneaker]!
        let cellIdentifier = "myGrailsCollectionViewCell"
        var collectionViewFlowLayout: UICollectionViewFlowLayout!
        var coreDataManager = CoreDataManager()
        @IBOutlet weak var myGrails_cv: UICollectionView!
        var nc = NotificationCenter.default
        override func viewDidLoad() {
            super.viewDidLoad()
            nc.addObserver(self, selector: #selector(reloadItems), name: Notification.Name("reloadGrails"), object: nil)
            setupCollectionView()
            
        }
    
    @objc func reloadItems(){
        self.items = coreDataManager.loadSavedSneakers()
        myGrails_cv.reloadData()
    }
        
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            if segue.identifier == "sneakerDetail_Segue" {
                let item = sender as! Sneaker
                if let vc = segue.destination as? SneakerDetailViewController{
                    vc.sneaker = item
                }
            }
        }
        

       private func setupCollectionView(){
                myGrails_cv.delegate = self
                myGrails_cv.dataSource = self
                let nib = UINib(nibName: "myGrailsCollectionViewCell", bundle: nil)
                myGrails_cv.register(nib, forCellWithReuseIdentifier: cellIdentifier)
                
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
                    
                    let width = (myGrails_cv.frame.width - (numberOfItemForRow - 1) * interItemSpacing)/numberOfItemForRow
                    let height = width
                    
                    collectionViewFlowLayout = UICollectionViewFlowLayout()
                    collectionViewFlowLayout.scrollDirection = .vertical
                
                    collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
                    collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
                    collectionViewFlowLayout.scrollDirection = .vertical
                    collectionViewFlowLayout.minimumLineSpacing = lineSpacing
                    collectionViewFlowLayout.minimumInteritemSpacing = interItemSpacing
                    
                    myGrails_cv.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
                }
            }

         
        }


    extension MyGrailsCollectionViewController: UICollectionViewDelegate,UICollectionViewDataSource{
        
            func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return items.count
            }
            
            func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! myGrailsCollectionViewCell
                
                let grail = items[indexPath.item]
                cell.grail = grail

                return cell
                
            }
            
            func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                selectedSneaker = items[indexPath.item]
           
                self.performSegue(withIdentifier: "sneakerDetail_Segue", sender: selectedSneaker)
                }
            
            
        }


    
