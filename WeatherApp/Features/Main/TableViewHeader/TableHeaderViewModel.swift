//
//  TableHeaderViewModel.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit

struct TableHeaderViewModel {
    
    var currentTemperatureLabel: String?
    var currentWeatherImageURL: URL?
    var dayLabel: String?
    var minLabel: String?
    var maxLabel: String?
    
    init(weatherData: Weather) {
        self.dayLabel = weatherData.day
        self.currentTemperatureLabel = weatherData.currentTemperature?.description
        self.maxLabel = weatherData.maxTemp?.description
        self.minLabel = weatherData.minTemp?.description
        if let url = URL(string: "http://openweathermap.org/img/w/" + weatherData.iconId + ".png") {
            self.currentWeatherImageURL = url
        }

    }
}
