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
    
    func testJSONParsingToWeatherModelForForecastList() {
        let requestManagerMock = RequestManagerMock()
        let weatherForecastManager = WeatherForecastManager(requestManager: requestManagerMock)
        let expectCurrentWeather = expectation(description: "GET Weather Forecast")
        weatherForecastManager.fetchForecastList { (weatherResult) in
            switch weatherResult {
            case .Error(_):
                XCTFail()
            case .Success(let weatherForecastArray):
                XCTAssertNotNil(weatherForecastArray, "Recieved forecast for 7 days")
                //Data based on dummy JSON Files
                XCTAssertEqual(weatherForecastArray[0].clouds, 0)
                XCTAssertEqual(weatherForecastArray[0].currentTemperature, nil)
                XCTAssertEqual(weatherForecastArray[0].pressure, 1016.38)
                XCTAssertEqual(weatherForecastArray[0].humidity, 40)
                XCTAssertEqual(weatherForecastArray[0].degree, 85)
                XCTAssertEqual(weatherForecastArray[0].speed, 1.86)
            }
            expectCurrentWeather.fulfill()
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
        let expectWeatherForecast = expectation(description: "GET Current Weather")
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
        let expectCurrentWeather = expectation(description: "GET Current Weather")
        weatherForecastManager.fetchCurrentWeather { (weatherResult) in
            switch weatherResult {
            case .Error(_):
                XCTFail()
            case .Success(let currentWeather):
                print("_______________________________")
                print(currentWeather)
                XCTAssertNotNil(currentWeather, "Recieved current Weather")
            }
            expectCurrentWeather.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            guard let error = error else { return }
            print(error)
        }
    }
    
    func testJSONParsingToWeatherModelForCurrentWeather() {
        let requestManagerMock = RequestManagerMock()
        let weatherForecastManager = WeatherForecastManager(requestManager: requestManagerMock)
        let expectCurrentWeather = expectation(description: "GET Current Weather")
        weatherForecastManager.fetchCurrentWeather { (weatherResult) in
            switch weatherResult {
            case .Error(_):
                XCTFail()
            case .Success(let currentWeather):
                print("_______________________________")
                print(currentWeather)
                XCTAssertNotNil(currentWeather, "Recieved current Weather")
                //Data based on dummy JSON Files
                XCTAssertEqual(currentWeather.clouds, 0)
                XCTAssertEqual(currentWeather.currentTemperature, 300.509)
                XCTAssertEqual(currentWeather.pressure, 1027.39)
                XCTAssertEqual(currentWeather.humidity, 80)
                XCTAssertEqual(currentWeather.degree, 93.504499999999993)
                XCTAssertEqual(currentWeather.speed, 4.7599999999999998)
            }
            expectCurrentWeather.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
            guard let error = error else { return }
            print(error)
        }
    }
    
}
