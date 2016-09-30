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
        let imageDataToTest = try? Data(contentsOf: URL(string: photo.url)!)
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
    
    // MARK: - Persistence Tests
    
    /**
        This function tests whether or not a given array of Photo objects can be converted to 
        a JSONObject.
 
    */
    
    func testConvertToPropertyList() {
        
        var photoCollection = [Photo]()
        
        photoCollection.append(Photo(title: "QUT", url: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png", tags: ["qut", "queensland", "university"]))
        photoCollection.append(Photo(title: "Griffith University", url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png", tags: ["griffith", "queensland", "university"]))
        photoCollection.append(Photo(title: "ACU", url: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg", tags: ["catholic", "queensland", "university"]))
        
        // convert array into NSDictionary format
        
        let arrayPhotoDic = photoCollection.map { $0.propertyListRepresentation() }
        
        XCTAssertTrue(JSONSerialization.isValidJSONObject(arrayPhotoDic))
    }
    
    /**
    
        This function tests the save data functionality.
        The data is saved into a JSON file.
    
    */
    
    func testWriteJSONToFile() {
        
        var photoCollection = [Photo]()
        
        photoCollection.append(Photo(title: "QUT", url: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png", tags: ["qut", "queensland", "university"]))
        photoCollection.append(Photo(title: "Griffith University", url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png", tags: ["griffith", "queensland", "university"]))
        photoCollection.append(Photo(title: "ACU", url: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg", tags: ["catholic", "queensland", "university"]))
        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        // convert array into NSDictionary format
        
        let arrayPhotoDic = photoCollection.map { $0.propertyListRepresentation() }
        
        // create NSData object to write data to file
        let data: Data
        try! data = JSONSerialization.data(withJSONObject: arrayPhotoDic, options: .prettyPrinted)
        
        // create json file
        
        let jsonFile = path.appendingPathComponent("photoTest.json")
        
        //write data to file
        
        XCTAssertTrue((try? data.write(to: URL(fileURLWithPath: jsonFile), options: [.atomic])) != nil)
        
    }
    
    /**
     
     This function tests the save data functionality.
     The data is saved into a JSON file.
     
     */
    
    func testLoadDataFromJSONFile() {
        
        var photoCollection = [Photo]()
        
        photoCollection.append(Photo(title: "QUT", url: "https://upload.wikimedia.org/wikipedia/en/thumb/9/9a/Queensland_University_of_Technology_(logo).svg/1017px-Queensland_University_of_Technology_(logo).svg.png", tags: ["qut", "queensland", "university"]))
        photoCollection.append(Photo(title: "Griffith University", url: "https://upload.wikimedia.org/wikipedia/en/2/2a/Griffith_University_logo.png", tags: ["griffith", "queensland", "university"]))
        photoCollection.append(Photo(title: "ACU", url: "http://www.pccevents.com.au/wp-content/uploads/2011/03/logo-acu-small.jpg", tags: ["catholic", "queensland", "university"]))
        
        // create path from Directory for the class for the converted class into a property list to be saved.
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! as NSString
        
        // convert array into NSDictionary format
        
        let arrayPhotoDic = photoCollection.map { $0.propertyListRepresentation() }
        
        // create NSData object to write data to file
        let data: Data
        try! data = JSONSerialization.data(withJSONObject: arrayPhotoDic, options: .prettyPrinted)
        
        // create json file
        
        let jsonFile = path.appendingPathComponent("photoTest.json")
        
        //write data to file
        try? data.write(to: URL(fileURLWithPath: jsonFile), options: [.atomic])
        
        // build the photo collection for the jsonFile
        
        // create NSData object
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: jsonFile))
        
        // create the array of dictionaries out of the jsonData NSData object
        
        let jsonArrayDic: [NSDictionary]
        
        try! jsonArrayDic = JSONSerialization.jsonObject(with: jsonData!, options: []) as! [NSDictionary]
        
        // create the array of Photo objects parsing a trailing closure to the map function of the jsonArrayDic
        // The closure will build a Photo object for each dictionary inside the jsonArrayDic
        
        let loadedPhotoCollection = jsonArrayDic.map { Photo(propertyList: $0) }
        
        XCTAssertNotNil(loadedPhotoCollection)
        
    }
    
    
}
