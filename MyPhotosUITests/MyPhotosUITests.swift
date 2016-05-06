//
//  MyPhotosUITests.swift
//  MyPhotosUITests
//
//  Created by Carlos Poles on 24/04/2016.
//  Copyright © 2016 Carlos Poles. All rights reserved.
//

import XCTest

class MyPhotosUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func wait(delay: NSTimeInterval = 2) {
        let runLoop = NSRunLoop.mainRunLoop()
        let someTimeInTheFuture = NSDate(timeIntervalSinceNow: delay)
        runLoop.runUntilDate(someTimeInTheFuture)
    }
    
    
    func waitNumberOfTries(value: XCUIElement, _ t: NSTimeInterval = 3) {
        let exists = NSPredicate(format:  "exists == true")
        let expectation = expectationForPredicate(exists, evaluatedWithObject: value, handler: nil)
        waitForExpectationsWithTimeout(t, handler: nil)
        print(expectation)
    }

    
    func testChangeToDetailViewAddButton() {
        
        let app = XCUIApplication()
        wait()
        let addButton = app.navigationBars["MyPhotos.MasterView"].buttons["Add"]
        let backButton = app.navigationBars["MyPhotos.DetailView"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0)
        
        while !addButton.exists {
            wait()
        }
        addButton.tap()
        
        while !backButton.exists {
            wait()
        }
        backButton.tap()
        
    }
    
    func testGoToPhotoFullView() {
        
        
        let app = XCUIApplication()
        let collectionViewQuery = app.collectionViews
        let secondItem = collectionViewQuery.childrenMatchingType(.Cell).elementBoundByIndex(1)
        let imageOfSecondItem = secondItem.otherElements.childrenMatchingType(.Image).element
        
        imageOfSecondItem.tap()

        
    }
    
}
