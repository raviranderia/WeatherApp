//
//  WeatherForecastManagerTest.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/20/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import XCTest
@testable import WeatherApp

class WeatherForecastManagerTest: XCTestCase {
    
    func testFetchForecastListWithError() {
        var requestManagerMock = RequestManagerMock()
        requestManagerMock.showError = true
        let weatherForecastManager = WeatherForecastManager(requestManager: requestManagerMock)
        let expectWeatherForecast = expectation(description: "GET Weather Forecast")
        weatherForecastManager.fetchForecastList { (weatherResult) in
            switch weatherResult {
            case .Error(let error):
                XCTAssertEqual("Error", error)
            case .Success(_):
                XCTFail()
            }
         expectWeatherForecast.fulfill()
        }
     
        waitForExpectations(timeout: 10) { (error) in
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testFetchForecastList() {
        let requestManagerMock = RequestManagerMock()
        let weatherForecastManager = WeatherForecastManager(requestManager: requestManagerMock)
        let expectWeatherForecast = expectation(description: "GET Weather Forecast")
        weatherForecastManager.fetchForecastList { (weatherResult) in
            switch weatherResult {
            case .Error(_):
                XCTFail()
            case .Success(let weatherForecastArray):
                print(weatherForecastArray)
                XCTAssertNotNil(weatherForecastArray, "Recieved forecast for 7 days")
            }
            expectWeatherForecast.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testCurrentWeatherWithError() {
        var requestManagerMock = RequestManagerMock()
        requestManagerMock.showError = true
        let weatherForecastManager = WeatherForecastManager(requestManager: requestManagerMock)
        let expectWeatherForecast = expectation(description: "GET Weather Forecast")
        weatherForecastManager.fetchCurrentWeather { (weatherResult) in
            switch weatherResult {
            case .Error(let error):
                XCTAssertEqual("Error", error)
            case .Success(_):
                XCTFail()
            }
            expectWeatherForecast.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testFetchCurrentWeather() {
        let requestManagerMock = RequestManagerMock()
        let weatherForecastManager = WeatherForecastManager(requestManager: requestManagerMock)
        let expectWeatherForecast = expectation(description: "GET Weather Forecast")
        weatherForecastManager.fetchCurrentWeather { (weatherResult) in
            switch weatherResult {
            case .Error(_):
                XCTFail()
            case .Success(let currentWeather):
                print("_______________________________")
                print(currentWeather)
                XCTAssertNotNil(currentWeather, "Recieved current Weather")
            }
            expectWeatherForecast.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            guard let error = error else { return }
            print(error)
        }
    }
}
