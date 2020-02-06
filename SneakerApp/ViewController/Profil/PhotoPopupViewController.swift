//
//  PhotoPopupViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 10.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

class PhotoPopupViewController: UIViewController {
    var uploadImage: UIImage?
    var uploadName: String?
    @IBOutlet weak var popupView: UIView!
    var coreDataManager = CoreDataManager()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MyProfilViewController
        if segue.identifier == "unwindCollection_Segue"{
            coreDataManager.saveCollectionPhoto(collectionPhoto: savedPhoto(picture: uploadImage,sneakerName: uploadName))
            destVC.loadSavedCollection()
        }
        
    }

    @IBAction func saveCollection(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveGrails(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PhotoPopupViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        print("Handle tap was called")
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        popupView.layer.cornerRadius = 8
        configureTapGesture()
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
