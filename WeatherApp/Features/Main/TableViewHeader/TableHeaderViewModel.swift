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
        self.currentTemperatureLabel = weatherData.currentTemperature?.description.degree
        self.maxLabel = weatherData.maxTemp?.description.degree
        self.minLabel = weatherData.minTemp?.description.degree
        if let iconId = weatherData.iconId, let url = URL(string: "http://openweathermap.org/img/w/" + iconId + ".png") {
            self.currentWeatherImageURL = url
        }

    }
}
