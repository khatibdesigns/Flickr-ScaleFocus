//
//  UIImageView.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    func downloadImage(_ url: String) {
        
        ImageDownloader.shared.addOperation(url: url,imageView: self) {  [weak self](result,downloadedImageURL)  in
            Threads.runOnMainThread {
                switch result {
                case .Success(let image):
                    self?.image = image
                case .Failure(_):
                    break
                case .Error(_):
                    break
                }
            }
        }
    }
}
