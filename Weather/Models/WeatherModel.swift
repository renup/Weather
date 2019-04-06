//
//  WeatherModel.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation

struct WeatherModel: Decodable {
    var cities: [City]?
}

struct City: Decodable {
    var country: String?
    var name: String?
    var temp: Double?
}

struct WeatherDetails: Decodable {
    var rainChance: Int?
    var humidity: Int?
    var longDescription: String?
    var feelsLike: Double?
    var sevenDay: WeekDay?
}

struct WeekDay: Decodable {
    var Monday: Day?
    var Tuesday: Day?
    var Wednesday: Day?
    var Thursday: Day?
    var Friday: Day?
    var Saturday: Day?
    var Sunday: Day?
}

struct Day: Decodable {
    var minTemp: Double?
    var maxTemp: Double?
    var shortDescription: String?
}
