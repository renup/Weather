//
//  ViewController.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var countryArray: [Country] = [] {
        didSet {
            weatherTableView.reloadData()
        }
    }
    
    var selectedCity: String = ""
    
    struct Constants {
        static let cellIdentifier = "weatherCell"
    }
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpWeatherScene()
        getWeather()
    }
    
    private func setUpWeatherScene() {
        weatherTableView.register(UINib(nibName: "WeatherCell", bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        weatherTableView.tableFooterView = UIView()
    }
    
    private func getWeather() {
        WeatherViewModel.fetchWeather {[weak self] (countryArray, error) in
            if error != nil {
                //show alert
            } else {
                guard let countryArr = countryArray else { return }
                self?.countryArray = countryArr
            }
        }
    }
    
}

extension WeatherViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return countryArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryArray[section].cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier) as! WeatherCell
        let country = countryArray[indexPath.section]
        cell.configureCell(country.cities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countryArray[section].name
    }
    
}

extension WeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = countryArray[indexPath.section]
        selectedCity = country.cities[indexPath.row].name!
        performSegue(withIdentifier: "weatherToDetailsVC", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailVC = segue.destination as? WeatherDetailsViewController {
            detailVC.cityName = self.selectedCity
        }
    }
}



