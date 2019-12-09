//
//  NikeViewController.swift
//  SneakerApp
//
//  Created by Dung  on 08.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class NikeViewController: UIViewController {
    @IBOutlet weak var calenderTop: UICollectionView!

    @IBOutlet weak var calenderBottom: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calenderTop.dataSource = self
        calenderTop.delegate = self
        
        calenderBottom.dataSource = self
        calenderBottom.delegate = self
        self.view.alpha = 1
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension NikeViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SneakerCell", for: indexPath) as! SneakerCollectionViewCell
        cell.sneaker = Sneaker(title: "Air Jordan 1 Retro", date: "12.12", img: UIImage(named: "j1")!)
        return cell
    }
    
    
    
}
extension NikeViewController : UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "SneakerDetailViewController") as? SneakerDetailViewController
        /// push the DetailViewController on the stack
        self.navigationController?.pushViewController(vc!,animated:true)
    }
}

