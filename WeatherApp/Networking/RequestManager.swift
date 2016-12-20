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

public enum WeatherResult<T> {
    case Success(T)
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

protocol RequestManagerProtocol {
     func dailyForecastWeatherByCityNameAsJson(cityName: String, numberOfDays: Int, data: @escaping (WeatherResult<JSON>) -> Void)
     func currentWeatherForecastByCityNameAsJson(cityName: String,data: @escaping (WeatherResult<JSON>) -> Void)
}


final class RequestManager: RequestManagerProtocol {
    private var params = [String : Any]()
    private var temperatureFormat: TemperatureFormat = .Kelvin {
        didSet {
            params["units"] = temperatureFormat.rawValue as Any?
        }
    }
    
    public init(apiKey: String) {
        params["appid"] = apiKey as Any?
    }
    
    public convenience init(apiKey: String, temperatureFormat: TemperatureFormat) {
        self.init(apiKey: apiKey)
        self.temperatureFormat = temperatureFormat
        self.params["units"] = temperatureFormat.rawValue as Any?
        
    }
    
    public func dailyForecastWeatherByCityNameAsJson(cityName: String, numberOfDays: Int, data: @escaping (WeatherResult<JSON>) -> Void) {
        params["q"] = cityName as Any?
        params["cnt"] = numberOfDays as Any?
        params["mode"] = "json" as Any?
        
        dailyForecastWeather() { data($0) }
    }
    
    public func currentWeatherForecastByCityNameAsJson(cityName: String,data: @escaping (WeatherResult<JSON>) -> Void) {
        params["q"] = cityName as Any?
        params["mode"] = "json" as Any?

        currentWeatherForecast() { data($0) }
    }
    
    private func apiCall(method: Router, response: @escaping (WeatherResult<JSON>) -> Void) {
        Alamofire.request(method).responseJSON { (weatherResponse) in
            let responseResult = weatherResponse.result
            if responseResult.isSuccess && responseResult.error == nil {
                let jsonDictionary = JSON(responseResult.value as Any)
                if jsonDictionary["cod"].stringValue != "200" {
                    response(.Error(jsonDictionary["message"].stringValue))
                }
                response(.Success(jsonDictionary))
            } else if let error = responseResult.error {
                response(.Error(error.localizedDescription))
            }
            else {
                response(.Error("Error"))
            }
            
        }
    }
    
    private func currentWeatherForecast(data: @escaping (WeatherResult<JSON>) -> Void) {
        apiCall(method: Router.Weather(params)) { data($0) }
    }
    
    private func dailyForecastWeather(data: @escaping (WeatherResult<JSON>) -> Void) {
        apiCall(method: Router.DailyForecast(params)) { data($0) }
    }

}
