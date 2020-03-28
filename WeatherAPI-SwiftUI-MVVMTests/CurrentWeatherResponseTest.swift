//
//  CurrentWeatherResponseTest.swift
//  WeatherAPI-SwiftUI-MVVMTests
//
//  Created by M.Waqas on 3/28/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import XCTest
@testable import WeatherAPI_SwiftUI_MVVM

class CurrentWeatherResponseTest: XCTestCase {

    var systemUnderTest: CurrentWeatherResponse!
    var systemUnderSecondTest: PresentableWeather!

     private let inPutData = Data("""
    {
      "coord": {
        "lon": 55.3,
        "lat": 25.26
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "scattered clouds",
          "icon": "03d"
        }
      ],
      "base": "stations",
      "main": {
        "temp": 306.42,
        "feels_like": 302.21,
        "temp_min": 303.71,
        "temp_max": 307.15,
        "pressure": 1011,
        "humidity": 20
      },
      "visibility": 6000,
      "wind": {
        "speed": 5.1,
        "deg": 220
      },
      "clouds": {
        "all": 28
      },
      "dt": 1585391291,
      "sys": {
        "type": 1,
        "id": 7537,
        "country": "AE",
        "sunrise": 1585361648,
        "sunset": 1585405994
      },
      "timezone": 14400,
      "id": 292223,
      "name": "Dubai",
      "cod": 200
    }
    """.utf8)

    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = try? JSONDecoder().decode(CurrentWeatherResponse.self, from: inPutData)
        systemUnderSecondTest = PresentableWeather(name: systemUnderTest.name ?? "", weather: [systemUnderTest])

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testDecoding_whenMissingType_itThrows() throws {
        AssertThrowsKeyNotFound("weather", decoding: CurrentWeatherResponse.self, from: try inPutData.json(deletingKeyPaths: "weather"))
    }

    func testDecoding_whenMissingAttributes_itThrows() throws {
        AssertThrowsKeyNotFound("main", decoding: CurrentWeatherResponse.self, from: try inPutData.json(deletingKeyPaths: "main"))
    }
    
    func testDecoding_WhenAllOK() throws {
        let _ = try JSONDecoder().decode(CurrentWeatherResponse.self, from: inPutData)
        XCTAssertTrue(true)
    }
    func testDateTime() {
        XCTAssertEqual(systemUnderTest.dataTime, "Mar 28")
    }
    
    func testSUT_InitializesId() {
        XCTAssertEqual(systemUnderSecondTest.id, systemUnderTest.name)
    }
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
