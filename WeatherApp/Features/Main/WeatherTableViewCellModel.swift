//
//  WeatherTableViewCellModel.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation

struct WeatherTableViewCellModel {
    
    var dayLabel: String
    var maxTempLabel: String?
    var minTempLabel: String?
    var iconImageURL: URL?
    
    init(weatherData: Weather) {
        self.dayLabel = weatherData.day
        if let maxTemp = weatherData.maxTemp, let minTemp = weatherData.minTemp {
            self.maxTempLabel = Int(maxTemp).description.degree
            self.minTempLabel = Int(minTemp).description.degree
        }
        if let iconId = weatherData.iconId, let url = URL(string: "http://openweathermap.org/img/w/" + iconId + ".png") {
            self.iconImageURL = url
        }
    }
}
