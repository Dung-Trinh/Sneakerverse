//
//  myGrailsCollectionViewCell.swift
//  SneakerApp
//
//  Created by Frank Pham on 26.01.20.
//  Copyright © 2020 Dung. All rights reserved.
//

import UIKit

protocol myGrailsDelegate: class {
    func delete(cell: myGrailsCollectionViewCell)
}

class myGrailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var blur_effect: UIVisualEffectView!
    @IBOutlet weak var grailImage: UIImageView!
    @IBOutlet weak var sneakerName: UILabel!
    @IBOutlet weak var buttonBackgroundView: UIVisualEffectView!
    weak var delegate: myGrailsDelegate!
    
    var isEditing: Bool = false {
        didSet {
            buttonBackgroundView.isHidden = !isEditing
        }
    }
    
    var grail: Sneaker! {
        didSet{
            updateUI()
        }
    }
    
    @IBAction func didTapButton(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    func updateUI(){
        
        let url = URL(string: grail!.imageURL)
        let data = try? Data(contentsOf: url!)
        
        grailImage.image = UIImage(data: data!)
        sneakerName.textColor = UIColor(red: 43/255, green: 17/255, blue: 187/255, alpha: 1.0)
        sneakerName.font = sneakerName.font.withSize(15)
        sneakerName.text = grail.title
        
    }
    
    private func setupDeleteButton() {
        buttonBackgroundView.layer.cornerRadius = buttonBackgroundView.bounds.width / 2.0
        buttonBackgroundView.layer.masksToBounds = true
        buttonBackgroundView.isHidden = !isEditing
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDeleteButton()
        
        // Initialization code
    }

}
