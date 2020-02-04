//
//  LoadingViewController.swift
//  SneakerApp
//
//  Created by Dung  on 14.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class LoadingViewController: UIViewController {
    @IBOutlet weak var gif: UIView!
    var player: AVPlayer?

 private func loadVideo() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        } catch { }

    let path = Bundle.main.path(forResource: "intro", ofType:"mp4")

    player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)

        playerLayer.frame = self.view.frame
    playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        playerLayer.zPosition = -1

        self.view.layer.addSublayer(playerLayer)

    player?.seek(to: CMTime.zero)
        player?.play()
    

    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadVideo()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 7, execute: {
            self.performSegue(withIdentifier: "toGuide_segue", sender: nil)
        })
    }




}
extension UIView {
    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: 0).isActive = true
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 0).isActive = true
        self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
        self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true

    }
}
