//
//  RequestManagerMock.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/20/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import SwiftyJSON

@testable import WeatherApp

struct RequestManagerMock: RequestManagerProtocol {
    
    var showError = false
    
    func dailyForecastWeatherByCityNameAsJson(cityName: String, numberOfDays: Int, data: @escaping (WeatherResult<JSON>) -> Void) {
        if showError {
            data(.Error("Error"))
        } else {
            getDummyWeatherForecast(fileName: "dummyWeatherForecast", completionHandler: { (weatherResult) in
                data(weatherResult)
            })
        }
    }
    
    func currentWeatherForecastByCityNameAsJson(cityName: String, data: @escaping (WeatherResult<JSON>) -> Void) {
        if showError {
            data(.Error("Error"))
        } else {
            getDummyWeatherForecast(fileName: "dummyCurrentWeather", completionHandler: { (weatherResult) in
                data(weatherResult)
            })
        }
    }
    
    func getDummyWeatherForecast(fileName: String, completionHandler: (WeatherResult<JSON>) -> ()) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType:"json") else {
            completionHandler(.Error("Error"))
            return
        }
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: filePath), options: .uncached)
            let jsonObj = JSON(data: data)
            completionHandler(.Success(jsonObj))
            
        } catch let error {
            completionHandler(.Error(error.localizedDescription))
        }
    }
}
