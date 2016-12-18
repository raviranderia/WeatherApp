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
    var day: String
    var speed: Double
    var pressure: Double
    var degree: Double
    
    //weather
    var mainWeather: String
    var mainWeatherDescription: String
    var iconId: String
    
    //temp
    var nightTemp: Double?
    var dayTemp: Double?
    var morningTemp: Double?
    var eveningTemp: Double?
    var minTemp: Double?
    var maxTemp: Double?
    
    //currentTemerature
    var currentTemperature: Double?
    
    
    init(weatherJSON: JSON) {
        self.clouds = weatherJSON["clouds"].intValue
        self.humidity = weatherJSON["humidity"].doubleValue
        self.dateTime = weatherJSON["dt"].doubleValue.convertTimeToString()
        self.day = weatherJSON["dt"].doubleValue.getDayFromTimestamp()
        self.speed = weatherJSON["speed"].doubleValue
        self.pressure = weatherJSON["pressure"].doubleValue
        self.degree = weatherJSON["degree"].doubleValue
        
        let weather = weatherJSON["weather"].arrayValue
        self.mainWeather = weather[0]["main"].stringValue
        self.mainWeatherDescription = weather[0]["description"].stringValue
        self.iconId = weather[0]["icon"].stringValue
        
        
        if let temperature = weatherJSON["temp"].dictionaryObject {
            self.nightTemp = temparature["night"] as? Double
            self.dayTemp = temparature["day"] as? Double
            self.morningTemp = temparature["morn"] as? Double
            self.eveningTemp = temparature["eve"] as? Double
            self.minTemp = temparature["min"] as? Double
            self.maxTemp = temparature["max"] as? Double
        }
        
        if let currentTemperature = weatherJSON["main"].dictionaryObject {
            self.currentTemperature = currentTemperature["temp"] as? Double
            self.minTemp = temparature["temp_min"] as? Double
            self.maxTemp = temparature["temp_max"] as? Double
        }
    
    }
    
}
