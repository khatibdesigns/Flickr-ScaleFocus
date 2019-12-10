//
//  ImageCollectionViewCell.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func prepareForReuse() {
        cellImageView.image = nil
    }
    
    var model: Image? {
        didSet {
            if let model = model {
                cellImageView.downloadImage(model.imageURL)
            }
        }
    }
}
