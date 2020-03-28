//
//  APIServiceErrorTest.swift
//  WeatherAPI-SwiftUI-MVVMTests
//
//  Created by M.Waqas on 3/28/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import XCTest
@testable import WeatherAPI_SwiftUI_MVVM

class APIServiceErrorTest: XCTestCase {

    let systemUnderTest = APIServiceError.networkError
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAPIServiceError() {
        XCTAssertEqual(systemUnderTest.localizedDescription, "Network is not available, please try again later.")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
