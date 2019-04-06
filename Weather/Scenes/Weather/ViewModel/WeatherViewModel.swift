//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

final class WeatherViewModel {
    
    @discardableResult
    static func fetchWeather(completion: @escaping WeatherResponse) -> URLSessionTask? {
        let task = WeatherRouter.getWeatherItems { (weatherModel, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, error)
                } else {
                    completion(weatherModel, nil)
                }
            }
        }
        return task
    }
    
    @discardableResult
    static func fetchWeatherDetail(city: String, completion: @escaping WeatherDetailsResponse) -> URLSessionTask? {
        let task = WeatherRouter.getWeatherDetail(for: city, completion: { (weatherDetail, error) in
            DispatchQueue.main.async {
                if error != nil {
                    completion(nil, error)
                } else {
                    completion(weatherDetail, nil)
                }
            }
        })
        return task
    }
    

}
