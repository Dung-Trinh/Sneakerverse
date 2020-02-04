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
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var saveToBtn: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    @IBOutlet weak var sneakerNameField: UITextField!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var takePhotoBtn: RoundButton!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveProfile_Segue"{
        let destVC = segue.destination as! MyProfilViewController
            destVC.self.myCollection.append(savedPhoto(picture: image, sneakerName: sneakerNameField.text))
        //destVC.myCollection_cv.reloadData()
    }
        else if segue.identifier == "saveTo_Segue"{
            let destVC = segue.destination as! PhotoPopupViewController
            destVC.uploadImage = image
            destVC.uploadName = sneakerNameField.text
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
    
    private func setupButtons(button: UIButton!){
        
        button.backgroundColor = UIColor.init(red: 43/255, green: 17/255, blue: 187/255, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.setTitleColor(.white, for: .normal)
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowRadius = 15
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    
    
    
 override func viewDidLoad() {
        super.viewDidLoad()
    
    imagePicker.delegate = self
    sneakerNameField.delegate = self
    configureTapGesture()
    setupButtons(button: saveBtn)
    setupButtons(button: saveToBtn)
    setupButtons(button: uploadBtn)
    //setupButtons(button: takePhotoBtn)

    
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

