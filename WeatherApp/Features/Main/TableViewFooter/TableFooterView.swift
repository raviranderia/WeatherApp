//
//  TableViewFooter.swift
//  WeatherApp
//
//  Created by RAVI RANDERIA on 12/19/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit

enum WeatherProperty: String {
    case Clouds
    case Humidity
    case Speed
    case Pressure
    case Degree
    
    func weatherPropertyValue(weatherData: Weather?) -> String? {
        guard let weatherData = weatherData else { return nil }
        switch self {
        case .Clouds:
            return weatherData.clouds.description
        case .Degree:
            return weatherData.degree.description
        case .Humidity:
            return weatherData.humidity.description
        case .Pressure:
            return weatherData.pressure.description
        case .Speed:
            return weatherData.speed.description
        }
    }
}

final class TableFooterView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    private var weatherData: Weather?
    
    class func instanceFromNib() -> TableFooterView {
        return UINib(nibName: "TableFooterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! TableFooterView
    }
    
    private var weatherProperties: [WeatherProperty] = [.Clouds, .Humidity, .Speed, .Pressure, .Degree]
    
    @IBOutlet weak var weatherDetailsTableView: UITableView!
    
    func configureWeatherDetailsTableView(weatherData: Weather) {
        self.weatherData = weatherData
        weatherDetailsTableView.delegate = self
        weatherDetailsTableView.dataSource = self
        registerCell()
        weatherDetailsTableView.tableFooterView = UIView()
        weatherDetailsTableView.reloadData()
    }
    
    private func registerCell() {
        let nib = UINib(nibName: "TableFooterViewCell", bundle: nil)
        weatherDetailsTableView.register(nib, forCellReuseIdentifier: "Cell")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherProperties.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableFooterViewCell
        let tableFooterViewCellModel = TableFooterViewCellModel(weatherProperty: weatherProperties[indexPath.row].rawValue, weatherPropertyValue: weatherProperties[indexPath.row].weatherPropertyValue(weatherData: weatherData))
        cell.configureTableFooterViewCell(tableFooterViewCellModel: tableFooterViewCellModel)
        return cell
    }
}
