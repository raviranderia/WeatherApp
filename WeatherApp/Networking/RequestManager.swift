//
//  RequestManager.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import MapKit

public enum TemperatureFormat: String {
    case Celsius = "metric"
    case Fahrenheit = "imperial"
    case Kelvin = ""
}

public enum WeatherResult {
    case Success(JSON)
    case Error(String)
    
    public var isSuccess: Bool {
        switch self {
        case .Success:
            return true
        case .Error:
            return false
        }
    }
}


class RequestManager {
    var params = [String : AnyObject]()
    public var temperatureFormat: TemperatureFormat = .Kelvin {
        didSet {
            params["units"] = temperatureFormat.rawValue as AnyObject?
        }
    }
    
    public init(apiKey: String) {
        params["appid"] = apiKey as AnyObject?
    }
    
    public convenience init(apiKey: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey)
        self.temperatureFormat = temperatureFormat
        self.params["units"] = temperatureFormat.rawValue as AnyObject?
        
    }
    
    public func dailyForecastWeatherByCityNameAsJson(cityName: String, numberOfDays: Int, data: @escaping (WeatherResult) -> Void) {
        params["q"] = cityName as AnyObject?
        params["cnt"] = numberOfDays as AnyObject?
        params["mode"] = "json" as AnyObject?
        
        dailyForecastWeather(parameters: params) { data($0) }
    }
    
    private func apiCall(method: Router, response: @escaping (WeatherResult) -> Void) {
        Alamofire.request(method).responseJSON { (weatherResponse) in
            let responseResult = weatherResponse.result
            if responseResult.isSuccess {
                let jsonDictionary = JSON(responseResult.value as Any)
                print(jsonDictionary)
            } else {
                response(.Error(responseResult.error.debugDescription))
            }
            
        }
    }
    
    private func dailyForecastWeather(parameters: [String:AnyObject], data: @escaping (WeatherResult) -> Void) {
        apiCall(method: Router.DailyForecast(params)) { data($0) }
    }

}
