//
//  PhotoTests.swift
//  MyPhotos
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import XCTest
@testable import MyPhotos

class PhotoTests: XCTestCase {
    
    
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
        let photo = Photo(title: titleToTest, url: "http://someweb.com", tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        XCTAssertNotNil(titleToTest)
        XCTAssertEqual(photo.title, titleToTest)
    }
    // test photo url property
    
    func testUrl() {
        let urlToTest = "http://someurltotest.com"
        let photo = Photo(title: "Photo Title", url: urlToTest, tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        XCTAssertEqual(photo.url, urlToTest)
        
    }
    
    // test tags property
    
    func testTags() {
        let tagsToTest = ["bri", "bsjeu", "jeijdl", "lekjd"]
        let photo = Photo(title: "Photo Title", url: "http://someweb.com", tags: tagsToTest)
        XCTAssertNotNil(tagsToTest)
        XCTAssertEqual(photo.tags!, tagsToTest)
    }
    
    // test imageData property
    
    func testImageData() {
        let photo = Photo(title: "Photo Title", url: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg", tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        let imageDataToTest = NSData(contentsOfURL: NSURL(string: photo.url)!)
        XCTAssertNotNil(imageDataToTest)
        photo.imageData = imageDataToTest
        XCTAssertEqual(photo.imageData, imageDataToTest)
        
        let photo2 = Photo(title: "Photo Title2", url:"http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg", tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        
        photo2.imageData = photo.imageData
        XCTAssertEqual(photo2.imageData, photo.imageData)
        
    }
    
    func testSettersAndGetters() {
        let titles = ["Title1", "Title2", "Title3", "Title4"]
        let urls = [ "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg", "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg", "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg", "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg"]
        let tags = [["bri", "bsjeu", "jeijdl", "lekjd"], ["sdff", "sdfsf", "sdfsdf", "sdf"], ["sewr", "dghhg", "gdfg", "dgg"], ["bdfggri", "bsdgfgjeu", "jeidfggjdl", "lekwerrrjd"]]
        
        let photo = Photo(title: "", url: "", tags: [])
        
        for title in titles {
            photo.title = title
            
            for url in urls {
                photo.url = url
                
                for tag in tags {
                    photo.tags = tag
                    
                    XCTAssertEqual(photo.title, title)
                    XCTAssertEqual(photo.url, url)
                    XCTAssertEqual(photo.tags!, tag)
                }
            }
        }
    }
    
    
    
}
