//
//  Weather.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Weather {
    var clouds: Int
    var humidity: Double
    var dateTime: String
    var speed: Double
    var pressure: Double
    var degree: Double
    
    //weather
    var mainWeather: String?
    var mainWeatherDescription: String?
    var iconId: String?
    
    //temp
    var night: Double?
    var day: Double?
    var morning: Double?
    var evening: Double?
    var min: Double?
    var max: Double?
    
    init(weatherJSON: JSON) {
        self.clouds = weatherJSON["clouds"].intValue
        self.humidity = weatherJSON["humidity"].doubleValue
        self.dateTime = weatherJSON["dt"].doubleValue.convertTimeToString()
        self.speed = weatherJSON["speed"].doubleValue
        self.pressure = weatherJSON["pressure"].doubleValue
        self.degree = weatherJSON["degree"].doubleValue
        
        if let weather = weatherJSON["weather"].dictionaryObject {
            self.mainWeather = weather["main"] as? String
            self.mainWeatherDescription = weather["description"] as? String
            self.iconId = weather["icon"] as? String
        }
        
        if let temparature = weatherJSON["temp"].dictionaryObject {
            self.night = temparature["night"] as? Double
            self.day = temparature["day"] as? Double
            self.morning = temparature["morning"] as? Double
            self.evening = temparature["evening"] as? Double
            self.min = temparature["min"] as? Double
            self.max = temparature["max"] as? Double
        }
    
    }
    
}
