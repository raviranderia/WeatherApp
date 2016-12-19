//
//  WeatherForecastManager.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import SwiftyJSON

struct WeatherForecastManager {
    private let requestManager: RequestManager
    
    private let currentCity = "Mumbai"
    private let numberOfDays = 7
    
    init(requestManager: RequestManager = RequestManager(apiKey: "e0ba8833aa1edee3f8d9c45c87dc412c", temperatureFormat: .Celsius)) {
        self.requestManager = requestManager
    }
    
    func fetchForecastList(handler: @escaping (([Weather]?) -> Void)) {
        var finalForecastArray = [Weather]()
        requestManager.dailyForecastWeatherByCityNameAsJson(cityName: currentCity, numberOfDays: numberOfDays) { (weatherResult) in
            switch weatherResult {
            case .Success(let jsonResult):
                let weatherForecastArray = jsonResult["list"].arrayValue
                for dayForecast in weatherForecastArray {
                    finalForecastArray.append(Weather(weatherJSON: dayForecast))
                }
                handler(finalForecastArray)
            case .Error(let error):
                print(error)
                handler(nil)
            }
        }
    }
    
    func fetchCurrentWeather(handler: @escaping (Weather?) -> Void) {
        requestManager.currentWeatherForecastByCityNameAsJson(cityName: currentCity) { weatherResult in
            switch weatherResult {
            case .Success(let jsonResult):
                handler(Weather(weatherJSON: jsonResult))
            case .Error(let error):
                print(error)
                handler(nil)
            }
        }
    }
}

