//
//  Image.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation

class Image {
    
    var imageURL = String()
    
    init(image: Photos) {
        
        self.imageURL = image.imageURL
    }
}
