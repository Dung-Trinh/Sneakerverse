//
//  myCollectionViewCell.swift
//  SneakerApp
//
//  Created by Frank Pham on 22.12.19.
//  Copyright © 2019 Dung. All rights reserved.
//

import UIKit

protocol myCollectionCellDelegate: class {
    func delete(cell: myCollectionViewCell)
}


class myCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var blur_effect: UIVisualEffectView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var sneakerName: UILabel!
    @IBOutlet weak var sneakerCount: UILabel!
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!
    weak var delegate: myCollectionCellDelegate?
    
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDeleteButton()
        
        // Initialization code
    }
    
    private func setupDeleteButton() {
        deleteButtonBackgroundView.layer.cornerRadius = deleteButtonBackgroundView.bounds.width / 2.0
        deleteButtonBackgroundView.layer.masksToBounds = true
        deleteButtonBackgroundView.isHidden = !isEditing
    }
    
    @IBAction func deleteButtonDidTap(_ sender: Any) {
        delegate?.delete(cell: self)
    }
    
}
