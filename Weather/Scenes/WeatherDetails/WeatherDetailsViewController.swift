//
//  WeatherDetailsViewController.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

final class WeatherDetailsViewController: UIViewController {
    
    struct Constants {
        static let cellIdentifier = "weekdayCell"
    }
    
    var cityName: String = ""
    var weekdayDataSource: WeekDay? {
        didSet {
            forecastTableView.reloadData()
        }
    }
    @IBOutlet weak var cityNameLabel: UILabel!
    
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    @IBOutlet weak var weatherFeelsLikeDescriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    @IBOutlet weak var rainChanceLabel: UILabel!
    
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var forecastTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stripSpaces()
        setupForecastTableView()
        getWeatherDetails()
    }
    
    private func setupForecastTableView() {
        forecastTableView.register(UINib(nibName: "WeekDayCell", bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        forecastTableView.tableFooterView = UIView()
    }
    
    private func stripSpaces() {
        let stripped = cityName.replacingOccurrences(of: " ", with: "")
        cityName = stripped
    }
    
    private func getWeatherDetails() {
        WeatherViewModel.fetchWeatherDetail(city: cityName) { [weak self] (weatherDetail, error) in
            if error != nil {
                //show alert
            } else {
                guard let `self` = self, let weatherDetails = weatherDetail else { return }
                self.cityNameLabel.text = self.cityName
                self.weatherDescriptionLabel.text = weatherDetails.longDescription
                self.temperatureLabel.text = weatherDetails.feelsLike?.description
                self.weatherFeelsLikeDescriptionLabel.text = weatherDetails.feelsLike?.description
                self.humidityLabel.text = weatherDetails.humidity?.description
                self.rainChanceLabel.text = weatherDetails.rainChance?.description
                self.weekdayDataSource = weatherDetails.sevenDay
            }
        }
    }
    
}

extension WeatherDetailsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Weekdays.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! WeekdayCell
        guard let dataSource = weekdayDataSource else { return UITableViewCell() }
        cell.configureCell(for: dataSource, indxPath: indexPath)
        return cell
    }
}
