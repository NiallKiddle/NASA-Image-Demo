//
//  APITests.swift
//  Milky Way demoTests
//
//  Created by Niall Kiddle on 20/03/2019.
//  Copyright © 2019 Intrica Studio. All rights reserved.
//

import XCTest
@testable import Milky_Way_demo

class NetworkTests: XCTestCase {
    
    var sessionUnderTest: URLSession!

    override func setUp() {
        super.setUp()
        
        sessionUnderTest = URLSession(configuration: URLSessionConfiguration.default)
    }

    override func tearDown() {
        super.tearDown()
        
        sessionUnderTest = nil
    }
    
    // MARK: - API calls
    
    func testCallToAPISucceeds()
    {
        let url = URL(string: "https://images-api.nasa.gov/search?q=milky%20way&media_type=image&year_start=2017&year_end=2017")
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            promise.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
    
    func testDecodeResponse()
    {
        let url = URL(string: "https://images-api.nasa.gov/search?q=milky%20way&media_type=image&year_start=2017&year_end=2017")
        let promise = expectation(description: "Completion handler invoked")
        
        var statusCode: Int?
        var responseError: Error?
        
        var itemModel: ItemModel?
        
        let dataTask = sessionUnderTest.dataTask(with: url!) { data, response, error in
            statusCode = (response as? HTTPURLResponse)?.statusCode
            responseError = error
            
            guard let data = data else { return XCTFail() }
            
            // Decode data
            do {
                let responseData = try JSONDecoder().decode(ResponseModel.self, from: data)
                guard let collection = responseData.collection else { return XCTFail() }
                
                itemModel = collection.items.first
                
            } catch let JSONErr {
                print("JSON Error: ", JSONErr)
                return
            }
            
            promise.fulfill()
        }
        dataTask.resume()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        // Ensure data has been correctly decoded into model
        XCTAssertNotNil(itemModel)
        XCTAssert(itemModel?.data?.first?.keywords?.count != 0)
        XCTAssert(itemModel?.data?.first?.title != "")
        XCTAssert(itemModel?.data?.first?.description != "")
        
        XCTAssertNil(responseError)
        XCTAssertEqual(statusCode, 200)
    }
}
