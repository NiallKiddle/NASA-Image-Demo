//
//  Milky_Way_demoTests.swift
//  Milky Way demoTests
//
//  Created by Niall Kiddle on 16/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import XCTest
@testable import Milky_Way_demo

class ControllerTests: XCTestCase {
    
    var controllerUnderTest: HomeViewController!

    override func setUp() {
        controllerUnderTest = HomeViewController()
    }

    override func tearDown() {
        controllerUnderTest = nil
    }
    
    func injectTestItem() {
        guard let controller = controllerUnderTest else { return }
        
        let data = DataModel(title: "Apollo 11 mission", date_created: "", center: "JSC", description: "Description", location: "Greenbelt, MD", media_type: "image", keywords: ["MOON","LUNAR","ASTRONAUTS"], nasa_id: "as11-40-5874")
        let links = LinksModel(render: "image", rel: "preview", href: "https://images-assets.nasa.gov/image/as11-40-5874/as11-40-5874~thumb.jpg")
        let item = ItemModel(href: "https://images-api.nasa.gov/search?q=apollo%2011", data: [data], links: [links])
    }
    
    func testSearchDidUpdateResults() {
        XCTAssertEqual(controllerUnderTest?.itemArray.count, 0, "searchResults should be empty before the data task runs")
    }
}
