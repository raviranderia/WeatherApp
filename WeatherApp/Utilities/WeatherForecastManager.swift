//
//  WeatherForecastManager.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol WeatherForecastManagerProtocol {
    func fetchForecastList(handler: @escaping (( WeatherResult<[Weather]>) -> Void))
    func fetchCurrentWeather(handler: @escaping (WeatherResult<(Weather)>) -> Void)
}

struct WeatherForecastManager: WeatherForecastManagerProtocol {
    private let requestManager: RequestManagerProtocol
    
    private let currentCity = "Mumbai"
    private let numberOfDays = 7
    
    init(requestManager: RequestManagerProtocol = RequestManager(apiKey: "YOUR_API_KEY", temperatureFormat: .Celsius)) {
        self.requestManager = requestManager
    }
    
    func fetchForecastList(handler: @escaping (( WeatherResult<[Weather]>) -> Void)) {
        var finalForecastArray = [Weather]()
        requestManager.dailyForecastWeatherByCityNameAsJson(cityName: currentCity, numberOfDays: numberOfDays) { (weatherResult) in
            switch weatherResult {
            case .Success(let jsonResult):
                let weatherForecastArray = jsonResult["list"].arrayValue
                for dayForecast in weatherForecastArray {
                    finalForecastArray.append(Weather(weatherJSON: dayForecast))
                }
                handler(.Success(finalForecastArray))
            case .Error(let error):
                handler(.Error(error))
            }
        }
    }
    
    func fetchCurrentWeather(handler: @escaping (WeatherResult<(Weather)>) -> Void) {
        requestManager.currentWeatherForecastByCityNameAsJson(cityName: currentCity) { weatherResult in
            switch weatherResult {
            case .Success(let jsonResult):
                handler(.Success(Weather(weatherJSON: jsonResult)))
            case .Error(let error):
                print(error)
                handler(.Error(error))
            }
        }
    }
}

