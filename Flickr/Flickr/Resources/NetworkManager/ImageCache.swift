//
//  ImageCache.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

class DataCache: NSObject {

    static let shared = DataCache()
    
    private(set) var cache: NSCache<AnyObject, AnyObject> = NSCache()
    
    func getImageFromCache(key: String) -> UIImage? {
        if (self.cache.object(forKey: key as AnyObject) != nil) {
            return self.cache.object(forKey: key as AnyObject) as? UIImage
        } else {
            return nil
        }
    }
    
    func saveImageToCache(key: String, image: UIImage) {
        self.cache.setObject(image, forKey: key as AnyObject)
    }
    
}
