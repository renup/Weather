//
//  WeatherEndpoint.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

enum WeatherEndpoint: APIConfiguration {
    
    case weather()
    
    struct Constants {
        static let baseURLString = "http://localhost:8080/"
        static let weather = "weather"
    }
    
    var path: String {
        switch self {
        case .weather():
            return Constants.baseURLString + Constants.weather
        }
    }
    
    var parameters: [URLQueryItem] {
        switch  self {
        case .weather():
           return []
        }
    }    
    
}
