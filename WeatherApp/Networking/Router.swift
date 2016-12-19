//
//  Router.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let baseURLString = "http://api.openweathermap.org/data/"
    static let apiVersion = "2.5"
    
    case Weather([String: Any])
    case Forecast([String: Any])
    case DailyForecast([String: Any])
    case HirstoricData([String: Any])
    
    var path: String {
        switch self {
        case .Weather:
            return "/weather"
        case .Forecast:
            return "/forecast"
        case .DailyForecast:
            return "/forecast/daily"
        case .HirstoricData:
            return "/history/city"
        }
    }
    
    // MARK: URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = URL(string: Router.baseURLString + Router.apiVersion)!
        
        func encode(params: [String: Any]) -> URLRequest {
            return Alamofire.request(url.appendingPathComponent(path), parameters: params, encoding: URLEncoding.default).request!
        }
        
        switch self {
        case .Weather(let parameters):
            return encode(params: parameters)
        case .Forecast(let parameters):
            return encode(params: parameters)
        case .DailyForecast(let parameters):
            return encode(params: parameters)
        case .HirstoricData(let parameters):
            return encode(params: parameters)
        }

    }

}
