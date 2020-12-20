//
//  PetCollectionViewCell.swift
//  PetManager
//
//  Created by Yihui Liao on 12/6/20.
//

import UIKit

class PetCollectionViewCell: UICollectionViewCell {
     
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    override func layoutSubviews() {
        petImage.layer.cornerRadius = petImage.bounds.height / 2
        petImage.clipsToBounds = true
    }
}
