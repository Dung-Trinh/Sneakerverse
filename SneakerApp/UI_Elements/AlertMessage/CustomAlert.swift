//
//  CustomAlert.swift
//  SneakerApp
//
//  Created by Dung  on 18.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

enum AlertType{
    case error
    case notification
    case fetch_successful
}
protocol AlertDelegate {
    func okTapped()
}

class CustomAlert: UIView {
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var alertDescription: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    var delegate : AlertDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("CustomAlert", owner: self, options: nil)
        self.okBtn.addTarget(self, action: #selector(remove), for: .touchUpInside)

        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        alertView.layer.cornerRadius = 15

        
    }
    
    @objc func remove(){
        print("remove")
        parentView.removeFromSuperview()
    }
    
    func showAlert(title: String, message: String, alertType: AlertType,view:UIView) {
        self.title.text = title
        self.alertDescription.text = message
        
        switch alertType {
        case .fetch_successful:
            self.img.image = #imageLiteral(resourceName: "jumpman")
            self.title.textColor = #colorLiteral(red: 0.4543082714, green: 0.7891098857, blue: 0.3882962763, alpha: 1)
            okBtn.backgroundColor = #colorLiteral(red: 0.4543082714, green: 0.7891098857, blue: 0.3882962763, alpha: 1)
        case .error:
            self.img.image = #imageLiteral(resourceName: "err_img")
            self.okBtn.backgroundColor = #colorLiteral(red: 0.8424913883, green: 0.2692174017, blue: 0.2339398265, alpha: 1)
            self.title.textColor = #colorLiteral(red: 0.8424913883, green: 0.2692174017, blue: 0.2339398265, alpha: 1)

        case .notification:
            self.img.image = #imageLiteral(resourceName: "err_img")
            self.title.textColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            self.okBtn.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        }
        
         self.alertView.transform = CGAffineTransform(translationX: 0, y: 50)
        self.alertView.alpha = 0
        view.addSubview(parentView)
        
        UIView.animate(withDuration: 1.0, delay: 0.2, options: [.curveEaseIn], animations: {
            self.alertView.transform = CGAffineTransform.identity
            self.alertView.alpha = 1

        })
      parentView.superview?.bringSubviewToFront(parentView)

    }
    
    @IBAction func button_click(_ sender: UIButton) {
        delegate?.okTapped()
    }
    

}
