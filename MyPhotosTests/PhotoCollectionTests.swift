//
//  PhotoCollectionTests.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import XCTest
@testable import MyPhotos

class PhotoCollectionTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // function to test the photoCollection property.
    
    func testPhotoCollection() {
        let photoCollectionToTest = [Photo(title: "Photo1", url: NSURL(string: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(title: "Photo2", url: NSURL(string: "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(url: NSURL(string: "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"])]
        let photoColletion = PhotoCollection()
        photoColletion.photoCollection = photoCollectionToTest
        XCTAssertEqual(photoColletion.photoCollection, photoCollectionToTest)
    }
    
    // function for testing setters and getters 
    
    func testSettersAndGetters() {
        let photoColletions = [[Photo(title: "Photo1", url: NSURL(string: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(title: "Photo2", url: NSURL(string: "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(url: NSURL(string: "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"])], [Photo(title: "Photo1", url: NSURL(string: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(title: "Photo2", url: NSURL(string: "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(url: NSURL(string: "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"])], [Photo(title: "Photo1", url: NSURL(string: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(title: "Photo2", url: NSURL(string: "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(url: NSURL(string: "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"])], [Photo(title: "Photo1", url: NSURL(string: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(title: "Photo2", url: NSURL(string: "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"]), Photo(url: NSURL(string: "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg")!, tags: ["dasdsd", "adsadsdsa", "adsadss"])]]
        
        let photos = PhotoCollection()
        
        // test each element of the photoCollection array.
        
        for collection in photoColletions {
            photos.photoCollection = collection
            
            XCTAssertEqual(photos.photoCollection, collection)
            
        }
        
    }

}
