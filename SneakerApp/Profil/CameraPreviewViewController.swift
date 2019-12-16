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
    @IBOutlet weak var photo: UIImageView!
    @IBAction func saveButton(_ sender: UIButton) {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photo.image = self.image
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
