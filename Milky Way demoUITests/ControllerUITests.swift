//
//  Milky_Way_demoUITests.swift
//  Milky Way demoUITests
//
//  Created by Niall Kiddle on 16/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import XCTest
@testable import Milky_Way_demo

class ControllerUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
    }
    
    func testInitialScreen() {
        app.launch()
        
        // Make sure we are displaying HomeViewController
        XCTAssertTrue(app.isDisplayingHome)
        
        // Check collection view
        XCTAssertTrue(app.isDisplayingCollectionView)
        
        // Check header view
        XCTAssertTrue(app.isDisplayingHeader)
    }
    
    func testNoSearchResults() {
        app.launch()
        
        // Make sure we are displaying HomeViewController
        XCTAssertTrue(app.isDisplayingHome)
        
        let searchTextField = app.textFields["searchTextField"]
        XCTAssertTrue(searchTextField.exists, "Text field doesn't exist")
        
        searchTextField.tap()
        searchTextField.typeText("***")
        XCTAssertEqual(searchTextField.value as! String, "***", "Text field value is not correct")
    }
    
    func testImageController() {
        app.launch()
        
        // Make sure we are displaying HomeViewController
        XCTAssertTrue(app.isDisplayingHome)
        
        let collectionView = app.collectionViews["collectionView"]
        
        // Waiting for cells to load
        sleep(5)
        
        let cell = collectionView.cells.element(boundBy: 0)
        XCTAssertTrue(cell.exists, "Cell doesn't exist")
        
        // Query empty collection view
        XCTAssertTrue(collectionView.cells.count > 0, "Collection view has no data")
        
        let cellImage = cell.images["cellImage"]
        XCTAssertTrue(cellImage.exists, "Cell image doesn't exist")
        
        cell.tap()
        
        // Waiting for view controller to finish animation
        sleep(2)
        
        // Make sure we are displaying ImageViewController
        XCTAssertTrue(app.isDisplayingImage, "Cannot find ImageViewController")
        
        // Check elements on page
        let scroll = app.scrollViews["scrollView"]
        XCTAssertTrue(scroll.exists, "Cannot find Scroll view")
        
        let imageView = app.otherElements["imageView"]
        XCTAssertTrue(imageView.exists, "Cannot find Image view")
        
        app.swipeUp()
        
        // Waiting for view controller to finish animation
        sleep(1)
        
        let textView = app.otherElements["textView"]
        XCTAssertTrue(textView.exists, "Cannot find Text view")
    }
}

// MARK: - isDisplaying Booleans
extension XCUIApplication {
    var isDisplayingHome: Bool {
        return otherElements["homeView"].exists
    }
    
    var isDisplayingImage: Bool {
        return otherElements["mainImageView"].exists
    }
    
    var isDisplayingCollectionView: Bool {
        return collectionViews["collectionView"].exists
    }
    
    var isDisplayingHeader: Bool {
        return otherElements["headerView"].exists
    }
}
