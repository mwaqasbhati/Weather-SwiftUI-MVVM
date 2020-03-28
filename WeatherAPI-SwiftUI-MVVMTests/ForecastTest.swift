//
//  ForecastTest.swift
//  WeatherAPI-SwiftUI-MVVMTests
//
//  Created by M.Waqas on 3/28/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import XCTest
@testable import WeatherAPI_SwiftUI_MVVM

class ForecastTest: XCTestCase {

    let expecteddt: Int = 12
    let expectedmain: MainClass = MainClass(temp: 1.0, feelsLike: 1.0, tempMin: 12.0, tempMax: 50.0, pressure: 2, seaLevel: 30, grndLevel: 2, humidity: 92, tempKf: 45.0)
    let expectedweather: [Weather] = [Weather]()
    let expectedclouds: Clouds = Clouds(all: 12)
    let expectedwind: Wind = Wind(speed: 23, deg: 5)
    let expectedsys: Sys = Sys(pod: Pod(rawValue: "d"))
    let expecteddtTxt: String = "2020-03-24 13:45:23"
    let expectedrain: Rain = Rain(the3H: 6.0)
    
    var systemUnderTest: Forecast!
    
    override func setUp() {
        super.setUp()
        
        systemUnderTest = Forecast(dt: expecteddt, main: expectedmain, weather: expectedweather, clouds: expectedclouds, wind: expectedwind, sys: expectedsys, dtTxt: expecteddtTxt, rain: expectedrain)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testSUT_InitializesDt() {
        XCTAssertEqual(systemUnderTest.dt, expecteddt)
    }
    
    func testSUT_InitializesMain() {
        XCTAssertNotNil(systemUnderTest.main)
        XCTAssert(systemUnderTest.main == expectedmain)
    }
    
    func testSUT_InitializesWeather() {
        XCTAssertNotNil(systemUnderTest.weather)
        XCTAssert(systemUnderTest.weather == expectedweather)
    }
    
    func testSUT_InitializesClouds() {
        XCTAssertNotNil(systemUnderTest.clouds)
        XCTAssert(systemUnderTest.clouds == expectedclouds)
    }
    
    func testSUT_InitializesWind() {
        XCTAssertNotNil(systemUnderTest.wind)
        XCTAssert(systemUnderTest.wind == expectedwind)
    }
    
    func testSUT_InitializeSys() {
        XCTAssertNotNil(systemUnderTest.sys)
        XCTAssert(systemUnderTest.sys == expectedsys)
    }
    
    func testSUT_InitializeRain() {
        XCTAssertNotNil(systemUnderTest.rain)
        XCTAssert(systemUnderTest.rain == expectedrain)
    }
    
    func testSUT_InitializeDtTxt() {
        XCTAssertEqual(systemUnderTest.dtTxt, expecteddtTxt)
    }
    
    func testSUT_WeekDayString() {
        XCTAssertEqual(systemUnderTest.weekDayString!, "Tuesday")
    }
    
    func testSUT_TimeString() {
        XCTAssertEqual(systemUnderTest.time!, "13:45")
    }
    
    func testSUT_WeekDay() {
        XCTAssertEqual(WeekDay(rawValue: 1)?.dayValue, "Sunday")
    }
    
    func testSUT_Id() {
        XCTAssertEqual(systemUnderTest.id, expecteddt)
    }
 }

