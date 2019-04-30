//
//  WeekdayCell.swift
//  Weather
//
//  Created by Renu Punjabi on 4/6/19.
//  Copyright © 2019 Renu Punjabi. All rights reserved.
//

import Foundation
import UIKit

enum Weekdays: String, CaseIterable {
    case Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday
    
    func description() -> String {
        return self.rawValue
    }
}

final class WeekdayCell: UITableViewCell {
    
    
    @IBOutlet weak var dayDescriptionLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func configureCell(for dataSource: WeekDay, indxPath: IndexPath) {
        let weekdayCases = Weekdays.allCases
        let dayOfTheWeek = weekdayCases[indxPath.row]
        var day = WeekDay().Sunday
        switch dayOfTheWeek {
        case .Monday:
            day = dataSource.Monday
        case .Tuesday:
            day = dataSource.Tuesday
        case .Wednesday:
            day = dataSource.Wednesday
        case .Thursday:
            day = dataSource.Thursday
        case .Friday:
            day = dataSource.Friday
        case .Saturday:
            day = dataSource.Saturday
        case .Sunday:
            day = dataSource.Sunday
        }
        
        dayLabel.text = dayOfTheWeek.rawValue
        guard let weekday = day, let desc = weekday.shortDescription, let minTmp = weekday.minTemp, let maxTmp = weekday.maxTemp else { return }
        dayDescriptionLabel.text = ": " + desc + " - " + minTmp.description + " to " + maxTmp.description
        
    }
}

