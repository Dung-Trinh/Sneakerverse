//
//  UploadViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 17.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

class UploadViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    var image: UIImage?
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var sneakernameLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var photo: UIImageView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier != "showCamera_Segue"{
        let destVC = segue.destination as! MyProfilViewController
        destVC.self.showCollection.append(Item(imageName: image))
        destVC.myCollection_cv.reloadData()
    }
    }
  
    @IBAction func showCameraButton(_ sender: UIButton) {
        performSegue(withIdentifier: "showCamera_Segue", sender: self)
    }
    @IBAction func uploadButton(_ sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
                       
                       imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
                       imagePicker.allowsEditing = true
                       imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
                       self.present(imagePicker, animated: true, completion: nil)
                       
                    }
                   else{
                       let alert = UIAlertController(title: "Warnung", message: "Du hast keine Berechtigung auf die Gallery", preferredStyle: .alert)
                       alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                       self.present(alert, animated: true, completion: nil)
                   }
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:
            [UIImagePickerController.InfoKey : Any]) {
            if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
                photo.image = pickedImage
                image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    
 override func viewDidLoad() {
        super.viewDidLoad()
    imagePicker.delegate = self
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
