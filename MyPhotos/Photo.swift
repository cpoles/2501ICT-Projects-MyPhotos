//
//  Photo.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import Foundation

class Photo {
    // MARK - Properties
    
    var title: String?
    var url: NSURL
    var tags: [String]?
    var imageData: NSData? {
        get {
            return NSData(contentsOfURL: url)
        }
    }
    
    // initialisation
    
    init(title: String? = nil, url: NSURL, tags: [String]? = nil) {
        self.title = title
        self.url = url
        self.tags = tags
    }
    
}