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
    @IBOutlet weak var sneakerNameField: UITextField!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var takePhotoBtn: RoundButton!
    var coreDataManager = CoreDataManager()
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveProfile_Segue"{
            if let addedPhoto = image {
                let destVC = segue.destination as! MyProfilViewController
                coreDataManager.saveCollectionPhoto(collectionPhoto: savedPhoto(picture: addedPhoto, sneakerName: sneakerNameField.text))
                destVC.loadSavedCollection()
                
            }
            
            else {
                let alert = CustomAlert()
                alert.showAlert(title: "Error:", message: "Kein Bild wurde mitgegeben", alertType: .error, view: self.view)
                
            }
            
                   
        }

    }
  
    @IBAction func saveTo(_ sender: Any) {
        
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
                photo.contentMode = .scaleAspectFill
                image = pickedImage
            }
            picker.dismiss(animated: true, completion: nil)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            dismiss(animated: true, completion: nil)
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UploadViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        print("Handle tap was called")
        view.endEditing(true)
        
    }
    
    
    
    
    
 override func viewDidLoad() {
        super.viewDidLoad()
    
    imagePicker.delegate = self
    sneakerNameField.delegate = self
    configureTapGesture()
    
    //let background = BackgroundColor()
    //background.createGradientBackground(view: self.view,colors: nil)
        // Do any additional setup after loading the view.
    }

}

extension UploadViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

