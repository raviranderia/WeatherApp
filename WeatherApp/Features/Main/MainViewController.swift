//
//  MainViewController.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let weatherForecastManager = WeatherForecastManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherForecastManager.fetchForecastList { (weatherArray) in
        }
    }

}

