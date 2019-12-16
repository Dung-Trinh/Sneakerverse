//
//  CameraViewController.swift
//  SneakerApp
//
//  Created by Frank Pham on 10.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//
import UIKit
import AVFoundation
class CameraViewController: UIViewController {
    
    var session: AVCaptureSession?
    var photoOutput: AVCapturePhotoOutput?
    var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    @IBOutlet weak var photoPreviewImageView: UIImageView!
    
    @IBAction func takePhotoButton(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPhoto_Segue" {
            let previewVC = segue.destination as! CameraPreviewViewController
            previewVC.image = self.image
        }
    }
 
    override func viewDidAppear(_ animated: Bool) {
       super.viewDidAppear(animated)
        videoPreviewLayer!.frame = photoPreviewImageView.bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = AVCaptureSession()
        session!.sessionPreset = AVCaptureSession.Preset.photo
        let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
        var error: NSError?
        var input: AVCaptureDeviceInput!
        
        do {
            input = try AVCaptureDeviceInput(device: backCamera!)
        } catch let error1 as NSError{
            error = error1
            input = nil
            print(error!.localizedDescription)
        }
        
        if error == nil && session!.canAddInput(input) {
            session!.addInput(input)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            
            if session!.canAddOutput(photoOutput!) {
                session!.addOutput(photoOutput!)
                videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
                videoPreviewLayer!.videoGravity =    AVLayerVideoGravity.resizeAspectFill
                videoPreviewLayer!.connection?.videoOrientation =   AVCaptureVideoOrientation.portrait
                photoPreviewImageView.layer.addSublayer(videoPreviewLayer!)
                session!.startRunning()
                
            }
        }
    }
}
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "showPhoto_Segue", sender: nil)
        }
    }

}
