//
//  CurrrentWeatherRequestTest.swift
//  WeatherAPI-SwiftUI-MVVMTests
//
//  Created by M.Waqas on 3/28/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import XCTest
@testable import WeatherAPI_SwiftUI_MVVM

class CurrrentWeatherRequestTest: XCTestCase {

    var systemUnderTest: CurrentWeatherRequest!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let params = ["q": "Dubai", "appid": Environment.API_KEY]
        systemUnderTest = CurrentWeatherRequest(params)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestInitialization() {
        let items = systemUnderTest.queryParams.map{
            URLQueryItem(name: $0.0, value: $0.1)
        }
        XCTAssertEqual(systemUnderTest.queryItems, items)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
