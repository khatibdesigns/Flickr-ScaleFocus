//
//  FlickrPhotos.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

struct FlickrPhotos: Codable {
    
    let page: Int
    let pages: Int
    let perpage: Int
    let photo: [Photos]
    let total: String
    
    init(page: Int, pages: Int, perpage: Int, photo: [Photos], total: String) {
        
        self.page = page
        self.pages = pages
        self.perpage = perpage
        self.photo = photo
        self.total = total
    }
}
