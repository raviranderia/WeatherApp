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
        self.degree = weatherJSON["deg"].doubleValue
        
        let weather = weatherJSON["weather"].arrayValue
        self.mainWeather = weather[0]["main"].stringValue
        self.mainWeatherDescription = weather[0]["description"].stringValue
        self.iconId = weather[0]["icon"].stringValue
        
        
        if let temperature = weatherJSON["temp"].dictionaryObject {
            self.nightTemp = temperature["night"] as? Double
            self.dayTemp = temperature["day"] as? Double
            self.morningTemp = temperature["morn"] as? Double
            self.eveningTemp = temperature["eve"] as? Double
            self.minTemp = temperature["min"] as? Double
            self.maxTemp = temperature["max"] as? Double
        }
        
        //Parsing for current temperature
        if let currentTemperature = weatherJSON["main"].dictionaryObject {
            self.currentTemperature = currentTemperature["temp"] as? Double
            self.minTemp = currentTemperature["temp_min"] as? Double
            self.maxTemp = currentTemperature["temp_max"] as? Double
            guard let pressure = currentTemperature["pressure"] as? Double,
                let humidity = currentTemperature["humidity"] as? Double else { return }
            self.pressure = pressure
            self.humidity = humidity
        }
        
        if let windInformation = weatherJSON["wind"].dictionaryObject {
            guard let speed = windInformation["speed"] as? Double, let degree = windInformation["deg"] as? Double else { return }
            self.speed = speed
            self.degree = degree
        }
        
        if let cloudInformation = weatherJSON["clouds"].dictionaryObject {
            guard let allClouds = cloudInformation["all"] as? Int else { return }
            self.clouds = allClouds
        }
    
    }
    
}
