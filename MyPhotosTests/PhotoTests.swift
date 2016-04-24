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
    
    // test tags property
    
    func testTags() {
        let tagsToTest = ["bri", "bsjeu", "jeijdl", "lekjd"]
        let photo = Photo(title: "Photo Title", url: NSURL(string: "http://someweb.com")!, tags: tagsToTest)
        XCTAssertNotNil(tagsToTest)
        XCTAssertEqual(photo.tags!, tagsToTest)
    }
    
    
    // test imageData property
    
    func testImageData() {
        let photo = Photo(title: "Photo Title", url: NSURL(string: "http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, tags: ["bri", "bsjeu", "jeijdl", "lekjd"])
        let imageDataToTest = photo.imageData
        XCTAssertNotNil(imageDataToTest)
        XCTAssertEqual(photo.imageData, imageDataToTest)
    }
    
    func testSettersAndGetters() {
        let titles = ["Title1", "Title2", "Title3", "Title4"]
        let urls = [ NSURL(string:"http://stuffpoint.com/cartoons/image/95692-cartoons-cartoon.jpg")!, NSURL(string: "http://stuffpoint.com/cartoons/image/187936-cartoons-pluto.jpg")!, NSURL(string: "http://stuffpoint.com/cartoons/image/174883-cartoons-cartoons.jpg")!, NSURL(string: "http://stuffpoint.com/cats/image/41633-cats-cute-cat.jpg")!]
        let tags = [["bri", "bsjeu", "jeijdl", "lekjd"], ["sdff", "sdfsf", "sdfsdf", "sdf"], ["sewr", "dghhg", "gdfg", "dgg"], ["bdfggri", "bsdgfgjeu", "jeidfggjdl", "lekwerrrjd"]]
        
        let photo = Photo(title: "", url: NSURL(string: "")!, tags: [])
        
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
