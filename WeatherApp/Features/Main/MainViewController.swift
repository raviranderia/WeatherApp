//
//  MainViewController.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    var weatherForecastArray = [Weather]()
    
    let weatherForecastManager = WeatherForecastManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherForecastManager.fetchForecastList { [weak self] weatherArray in
            guard let strongSelf = self,
                let weatherForecastArray = weatherArray else { return }
            strongSelf.weatherForecastArray = weatherForecastArray
            DispatchQueue.main.async {
                strongSelf.weatherTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherForecastArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        let weatherTableViewCellModel = WeatherTableViewCellModel(weatherData: weatherForecastArray[indexPath.row])
        cell.configureCell(weatherTableCellViewModel: weatherTableViewCellModel)
        return cell
    }
    

}

