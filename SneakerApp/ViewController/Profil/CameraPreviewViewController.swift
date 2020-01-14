//
//  CameraPreviewViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 11.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//
import UIKit
class CameraPreviewViewController: UIViewController {
    var image: UIImage!
    @IBOutlet weak var sneakernameLabel: UILabel!
    @IBOutlet weak var sneakerdateLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBAction func saveButton(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        
        dismiss(animated: true, completion: nil)
    }
   
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! MyProfilViewController
        destVC.self.showCollection.append(Item(imageName: image))
        destVC.myCollection_cv.reloadData()
    }
    
    
   override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
        
        
        
        /*
        let pickerController = UIImagePickerController()
        pickerController.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        pickerController.allowsEditing = true
        pickerController.mediaTypes = ["public.image"]
        pickerController.sourceType = .camera */
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