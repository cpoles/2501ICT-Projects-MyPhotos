//
//  PhotoTests.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import XCTest

class PhotoTests: XCTestCase {
    
    class Photo {
        // MARK - Properties
        
        var title: String?
        var url: NSURL
        var tags: [String]?
        var imageData: NSData?
        
        // initialisation
        
        init(title: String? = nil, url: NSURL, tags: [String]? = nil) {
            self.title = title
            self.url = url
            self.tags = tags
        }
        
    }
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
   
    //MARK: - Photo Class Tests 
    
    // Test photo title property
    
    func testTitle() {
        let titleToTest = "Photo Title"
        let photo = Photo(title: titleToTest, url: NSURL(string: "http://someweb.com")!, tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        XCTAssertNotNil(titleToTest)
        XCTAssertEqual(photo.title, titleToTest)
    }
    // test photo url property
    
    func testUrl() {
        let urlToTest = NSURL(string:"http://someurltotest.com")
        let photo = Photo(title: "Photo Title", url: urlToTest!, tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        XCTAssertEqual(photo.url, urlToTest)
        
    }
    
    
    
    
}
