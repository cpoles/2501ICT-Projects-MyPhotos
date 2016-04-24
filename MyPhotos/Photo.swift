//
//  Photo.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import Foundation

class Photo : Equatable {
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

func ==(lhs: Photo, rhs: Photo) -> Bool {
    
    return lhs.title! == rhs.title! && lhs.url == rhs.url && lhs.tags! == rhs.tags! && lhs.imageData! == rhs.imageData!
}