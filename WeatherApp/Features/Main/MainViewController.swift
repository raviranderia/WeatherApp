//
//  MainViewController.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/18/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit
import PureLayout

final class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    private var weatherForecastArray = [Weather]()
    private let weatherForecastManager = WeatherForecastManager()
    private let errorSegueIdentifier = "internetConnectionSegue"
    private var errorMessage: String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        weatherForecastManager.fetchForecastList { [weak self] weatherResult in
            guard let strongSelf = self else { return }
            switch weatherResult {
            case .Success(let weatherForecastArray):
                if let weatherForecastArray = weatherForecastArray {
                    strongSelf.weatherForecastArray = weatherForecastArray
                    DispatchQueue.main.async {
                        strongSelf.weatherTableView.reloadData()
                    }
                }
            case .Error(let error):
                strongSelf.displayErrorAlert(message: error)
            }
        }
    }
    
    private func configureCurrentWeather() {
        weatherForecastManager.fetchCurrentWeather { [weak self] (weatherResult) in
            guard let strongSelf = self else { return }
            switch weatherResult {
            case .Success(let currentWeather):
                if let currentWeather = currentWeather {
                    DispatchQueue.main.async {
                        strongSelf.configureTableViewHeader(currentWeather: currentWeather)
                        strongSelf.configureTableViewFooter(currentWeather: currentWeather)
                    }
                }
            case .Error(let error):
                strongSelf.displayErrorAlert(message: error)
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
    
    func displayErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.errorMessage = message
            self.performSegue(withIdentifier: self.errorSegueIdentifier , sender: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destinationVC = segue.destination as? ErrorViewController {
            destinationVC.errorMessage = errorMessage
        }
    }

}

