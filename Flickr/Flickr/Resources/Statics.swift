//
//  Statics.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

class Statics: Codable {

    static let api_key = "3e7cc266ae2b0e0d78e279ce8e361736"
    static let searchURL = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key)&format=json&nojsoncallback=1&safe_search=1&text=%@&page=%ld"
    static let imageURL = "https://farm%d.staticflickr.com/%@/%@_%@_\(size.url_s.value).jpg"
    
    enum size: String {
        case url_sq = "s"   //small square 75x75
        case url_q = "q"    //large square 150x150
        case url_t = "t"    //thumbnail, 100 on longest side
        case url_s = "m"    //small, 240 on longest side
        case url_n = "n"    //small, 320 on longest side
        case url_m = "-"    //medium, 500 on longest side
        case url_z = "z"    //medium 640, 640 on longest side
        case url_c = "c"    //medium 800, 800 on longest side†
        case url_l = "b"    //large, 1024 on longest side*
        case url_h = "h"    //large 1600, 1600 on longest side†
        case url_k = "k"    //large 2048, 2048 on longest side†
        case url_o = "o"    //original image, either a jpg, gif or png, depending on source format
        
        var value: String {
            return self.rawValue
        }
    }
    
    static let ColumnCount: CGFloat = 3.0
}
