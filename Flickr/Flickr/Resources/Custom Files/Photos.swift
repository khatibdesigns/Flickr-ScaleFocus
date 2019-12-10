//
//  Photos.swift
//  Flickr
//
//  Created by Khatib Designs on 12/10/19.
//  Copyright © 2019 Khatib Designs. All rights reserved.
//

import Foundation

class Photos: Codable {
    
    var id = String()
    var title = String()
    var owner = String()
    var secret = String()
    var server = String()
    
    var isfamily = Int()
    var isfriend = Int()
    var ispublic = Int()
    var farm = Int()
    
    
    init(id: String, title: String, owner: String, secret: String, server: String, isfamily: Int, isfriend: Int, ispublic: Int, farm: Int) {
        
        self.id = id
        self.title = title
        self.owner = owner
        self.secret = secret
        self.server = server
        self.isfamily = isfamily
        self.isfriend = isfamily
        self.ispublic = isfamily
        self.farm = farm
    }
    
    var imageURL: String {
        let urlString = String(format: Statics.imageURL, farm, server, id, secret)
        return urlString
    }
}
