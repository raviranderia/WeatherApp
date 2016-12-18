//
//  MainViewController.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let requestManager = RequestManager(apiKey: "e0ba8833aa1edee3f8d9c45c87dc412c", temperatureFormat: .Celsius)

    override func viewDidLoad() {
        super.viewDidLoad()
        requestManager.dailyForecastWeatherByCityNameAsJson(cityName: "Mumbai", numberOfDays: 7) { (result) in
            switch result {
            case .Error(let error):
                print(error)
            case .Success(let json):
                print(json)
            }
        }
    }

}

