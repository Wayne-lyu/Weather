//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by wayne.lv on 2019/3/29.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        DarkSkyService.shared.getForecast(latitude: 34, longitude: 118) { result in
            if let forecast = result.value {
                XCTAssert(forecast.latitude == 34)
                XCTAssert(forecast.longitude == 118)
            }
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
            DarkSkyService.shared.getForecast(latitude: 34, longitude: 118) { result in
            }
        }
    }
    
}
