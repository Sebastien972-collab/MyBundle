//
//  WeatherServiceTest.swift
//  MyBundleTests
//
//  Created by DAGUIN Sébastien on 10/06/2021.
//

@testable import MyBundle
import XCTest

class WeatherServiceTest: XCTestCase {
    func testGetWeatherPostFailedCallBackError() {
        let weatheService = WeatherService(session: URLSessionFake(data: nil, response: nil, responseError: FakeWeatherService.error))
        
        let expactation = XCTestExpectation(description: "Wait for queue change")
        
        
        weatheService.getWeather(city: "", fromCountry: "") { success, error, weather, description in
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            XCTAssertNil(weather)
            XCTAssertNil(description)
            expactation.fulfill()
        }
        
    }
    func testGetWeatherPostFailedCallBackIFResponseKO() {
        let weatheService = WeatherService(session: URLSessionFake(data: nil, response: URLResponseFake.responseKO, responseError: FakeWeatherService.error))
        
        let expactation = XCTestExpectation(description: "Wait for queue change")
        
        
        weatheService.getWeather(city: "", fromCountry: "") { success, error, weather, description in
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            XCTAssertNil(weather)
            XCTAssertNil(description)
            expactation.fulfill()
        }
    }
    func testGetWeatherPostFailedCallBackIFResponseOK() {
        let weatheService = WeatherService(session: URLSessionFake(data: nil, response: URLResponseFake.responseOK, responseError: FakeWeatherService.error))
        
        let expactation = XCTestExpectation(description: "Wait for queue change")
        
        
        weatheService.getWeather(city: "", fromCountry: "") { success, error, weather, description in
            XCTAssertFalse(success)
            XCTAssertNotNil(error)
            XCTAssertNil(weather)
            XCTAssertNil(description)
            expactation.fulfill()
        }
        
    }
    func testGetWeatherPostSuccessCallBack() {
        
        let weatheService = WeatherService(session: URLSessionFake(data: FakeWeatherService.weatherCorrect, response: URLResponseFake.responseOK, responseError: nil))
        
        let expactation = XCTestExpectation(description: "Wait for queue change")
        
        
        weatheService.getWeather(city: "", fromCountry: "") { success, error, weather, description in
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssertNotNil(weather)
            XCTAssertNotNil(description)
            expactation.fulfill()
        }
       
    }
}

