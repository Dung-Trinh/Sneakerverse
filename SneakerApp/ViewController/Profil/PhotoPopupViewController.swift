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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MyProfilViewController
        if segue.identifier == "unwindCollection_Segue"{
            destVC.myCollection.append(savedPhoto(picture: uploadImage,sneakerName: uploadName))
            
        }
        
    }
    @IBAction func saveCollection(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func saveGrails(_ sender: Any) {
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
