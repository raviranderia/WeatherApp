//
//  TableFooterViewModel.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation

struct TableFooterViewCellModel {
    var weatherProperty: String?
    var weatherPropertyValue: String?
    
    init(weatherProperty: String?, weatherPropertyValue: String?) {
        self.weatherProperty = weatherProperty
        self.weatherPropertyValue = weatherPropertyValue
    }
}
