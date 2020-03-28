//
//  ForecastViewModel_Tests.swift
//  WeatherAPI-SwiftUI-MVVMTests
//
//  Created by M.Waqas on 3/28/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import XCTest
import Combine
@testable import WeatherAPI_SwiftUI_MVVM

class ForecastViewModel_Tests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testInitializeObject() {
        let forecast = ForecastViewModel(apiService: APIService())
        XCTAssertTrue(forecast.forecast.count == 0)
    }
    
    func testSinkReceiveDataThenError() {
        // setup
        let forecast = ForecastViewModel(apiService: APIService())

        _ = forecast.$isErrorShown.sink { (value) in
            XCTAssertNotNil(value)
            XCTAssertEqual(value, false)
        }
                
        _ = forecast.$errorMessage.sink { (value) in
            XCTAssertNotNil(value)
            XCTAssertEqual(value, "")
        }
                
        _ = forecast.$isLoading.sink { (value) in
            XCTAssertNotNil(value)
            XCTAssertEqual(value, true)
        }
                
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
