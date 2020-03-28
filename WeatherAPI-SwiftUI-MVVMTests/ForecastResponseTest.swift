//
//  ForecastResponseTest.swift
//  WeatherAPI-SwiftUI-MVVMTests
//
//  Created by M.Waqas on 3/28/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import XCTest
@testable import WeatherAPI_SwiftUI_MVVM

class ForecastResponseTest: XCTestCase {

    let expectedcod: String? = "some"
    let expectedmessage: Int? = 12
    let expectedcnt: Int? = 23
    let expectedlist: [Forecast] = [Forecast]()
    let expectedcity: City = City(id: 12, name: "Dubai", coord: Coord(lat: 123.67, lon: 122.333), country: "UAE", population: 123456, timezone: 1324, sunrise: 4566, sunset: 98766)

    var systemUnderTest: ForecastResponse!
    var systemUnderSecondTest: PresentableForecast!

 private let inPutData = Data("""
{
  "cod": "200",
  "message": 0,
  "cnt": 40,
  "list": [
    {
      "dt": 1585159200,
      "main": {
        "temp": 294.54,
        "feels_like": 293.95,
        "temp_min": 294.48,
        "temp_max": 294.54,
        "pressure": 1012,
        "sea_level": 1012,
        "grnd_level": 1011,
        "humidity": 61,
        "temp_kf": 0.06
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "scattered clouds",
          "icon": "03n"
        }
      ],
      "clouds": {
        "all": 26
      },
      "wind": {
        "speed": 2.43,
        "deg": 305
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-03-25 18:00:00"
    }
  ],
  "city": {
    "id": 292223,
    "name": "Dubai",
    "coord": {
      "lat": 25.2582,
      "lon": 55.3047
    },
    "country": "AE",
    "population": 1137347,
    "timezone": 14400,
    "sunrise": 1585102637,
    "sunset": 1585146716
  }
}
""".utf8)
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        systemUnderTest = ForecastResponse(cod: expectedcod, message: expectedmessage, cnt: expectedcnt, list: expectedlist, city: expectedcity)
        systemUnderSecondTest = PresentableForecast(weekDay: "Tuesday", name: systemUnderTest.city.name ?? "", forecast: systemUnderTest.list)
    }
    
    func testDecoding_whenMissingType_itThrows() throws {
        AssertThrowsKeyNotFound("list", decoding: ForecastResponse.self, from: try inPutData.json(deletingKeyPaths: "list"))
    }

    func testDecoding_whenMissingAttributes_itThrows() throws {
        AssertThrowsKeyNotFound("city", decoding: ForecastResponse.self, from: try inPutData.json(deletingKeyPaths: "city"))
    }
    
    func testDecoding_WhenAllOK() throws {
        let _ = try JSONDecoder().decode(ForecastResponse.self, from: inPutData)
        XCTAssertTrue(true)
    }

    func testSUT_InitializesId() {
        XCTAssertEqual(systemUnderSecondTest.id, "Tuesday")
    }
    
    func testSUT_InitializesCod() {
        XCTAssertEqual(systemUnderTest.cod, expectedcod)
    }
    
    func testSUT_InitializesMessage() {
        XCTAssertEqual(systemUnderTest.message, expectedmessage)
    }
    
    func testSUT_InitializesCnt() {
        XCTAssertEqual(systemUnderTest.cnt, expectedcnt)
    }
    
    func testSUT_InitializesList() {
        XCTAssertNotNil(systemUnderTest.list)
        XCTAssert(systemUnderTest.list == expectedlist)
    }
    
    func testSUT_InitializesCity() {
        XCTAssertNotNil(systemUnderTest.city)
        XCTAssert(systemUnderTest.city == expectedcity)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

func AssertThrowsKeyNotFound<T: Decodable>(_ expectedKey: String, decoding: T.Type, from data: Data, file: StaticString = #file, line: UInt = #line) {
    XCTAssertThrowsError(try JSONDecoder().decode(decoding, from: data), file: file, line: line) { error in
        if case .keyNotFound(let key, _)? = error as? DecodingError {
            XCTAssertEqual(expectedKey, key.stringValue, "Expected missing key '\(key.stringValue)' to equal '\(expectedKey)'.", file: file, line: line)
        } else {
            XCTFail("Expected '.keyNotFound(\(expectedKey))' but got \(error)", file: file, line: line)
        }
    }
}

extension Data {
    func json(deletingKeyPaths keyPaths: String...) throws -> Data {
        let decoded = try JSONSerialization.jsonObject(with: self, options: .mutableContainers) as AnyObject

        for keyPath in keyPaths {
            decoded.setValue(nil, forKeyPath: keyPath)
        }

        return try JSONSerialization.data(withJSONObject: decoded)
    }
}
