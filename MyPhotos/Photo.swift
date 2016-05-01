//
//  Photo.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import Foundation

protocol PropertyListable {
    func propertyListRepresentation() -> NSDictionary
}

class Photo {
    // MARK - Properties
    
    /// the title of the Photo object.
    var title: String?
    /// the url of the image of the Photo object.
    var url: String
    /// the related photo tags.
    var tags: [String]?
    /// imageData is the representation of the image that will be downloaded from the url provided as NSData.
    var imageData: NSData?
    
    // MARK: - Initialization
    
    init(title: String? = nil, url: String, tags: [String]? = nil) {
        self.title = title
        self.url = url
        self.tags = tags
    }
    
}

    // MARK: - Extension

extension Photo : PropertyListable {
    
    // MARK: - Methods
    
    /**
     - parameters:
     - none
     - The propertyListRepresentation function converts the photo object to NSDictionary format so that the Photo object can be represented as a JSON object and written to a json file.
     - returns: NSDictionary
     */
    func propertyListRepresentation() -> NSDictionary {
        let propertyList: NSDictionary = [
            PropertyKey.titleKey : title!,
            PropertyKey.urlKey : url,
            PropertyKey.tagsKey : tags!
        ]
        return propertyList
    }
    
    // MARK: - Initialization
    
    convenience init(propertyList: NSDictionary) {
        let title = (propertyList.objectForKey(PropertyKey.titleKey) as! String) //parsing the value of the pair on the dictionary to the title property.
        
        let url = (propertyList.objectForKey(PropertyKey.urlKey) as! String)
        let tags = (propertyList.objectForKey(PropertyKey.tagsKey) as! [String])
        self.init(title: title, url: url, tags: tags)
    }
}

// MARK: PropertyKey Struct


/**
 The PropertyKey Struct holds the keys that will be used on the
 Dictionary returned by propertyListRepresentation().
 The struct properties are downcasted to NSSTring to
 conform to isValidJSon so that the Dictionary is
 serializable to json format.
 
 */

struct PropertyKey {
    
    static let titleKey = "title" as NSString
    static let urlKey = "url" as NSString
    static let tagsKey = "tags" as NSString
    
}

// MARK: - Equatable

func ==(lhs: Photo, rhs: Photo) -> Bool {
    
    return lhs.title! == rhs.title! && lhs.url == rhs.url && lhs.tags! == rhs.tags! && lhs.imageData! == rhs.imageData!
}