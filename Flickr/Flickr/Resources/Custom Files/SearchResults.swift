//
//  SearchResults.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

struct SearchResults: Codable {
    
    var stat: String?
    var photos: FlickrPhotos?
    
    init(stat: String, photos: FlickrPhotos) {
        
        self.stat = stat
        self.photos = photos
    }
}
