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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
