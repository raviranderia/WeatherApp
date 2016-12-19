//
//  MainViewController.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

final class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    private var weatherForecastArray = [Weather]()
    private let weatherForecastManager = WeatherForecastManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureWeatherForecastArray()
        configureCurrentWeather()
    }
    
    private func configureTableViewHeader(currentWeather: Weather?) {
        guard let currentWeather = currentWeather else { return }
        let tableHeaderView = TableHeaderView.instanceFromNib()
        let tableHeaderViewModel = TableHeaderViewModel(weatherData: currentWeather)
        tableHeaderView.configureTableViewHeader(tableHeaderViewModel: tableHeaderViewModel)
        weatherTableView.tableHeaderView = tableHeaderView
    }
    
    private func configureTableViewFooter(currentWeather: Weather?) {
        guard let currentWeather = currentWeather else { return }
        let tableFooterView = TableFooterView.instanceFromNib()
        tableFooterView.configureWeatherDetailsTableView(weatherData: currentWeather)
        weatherTableView.tableFooterView = tableFooterView
    }
    
    private func configureWeatherForecastArray() {
        weatherForecastManager.fetchForecastList { [weak self] weatherArray in
            guard let strongSelf = self,
                let weatherForecastArray = weatherArray else { return }
            strongSelf.weatherForecastArray = weatherForecastArray
            DispatchQueue.main.async {
                strongSelf.weatherTableView.reloadData()
            }
        }
    }
    
    private func configureCurrentWeather() {
        weatherForecastManager.fetchCurrentWeather { (currentWeather) in
            DispatchQueue.main.async {
                print(currentWeather)
                self.configureTableViewHeader(currentWeather: currentWeather)
                self.configureTableViewFooter(currentWeather: currentWeather)
            }
        }
    }
    
    // MARK: TableViewDataSource
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

