//
//  WeatherDetailItemViewModel.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import Foundation
import WeatherKit

struct WeatherDetailItemViewModel: Identifiable {
    let dateTime: Date
    let symbolName: String
    let temp: String
    
    var id: Date {
        return dateTime
    }
    
    var timeString: String {
        return dateTime.timeIn24HourFormat()
    }
}

extension WeatherDetailItemViewModel {
    init(hourlyWeather: HourWeather) {
        dateTime = hourlyWeather.date
        symbolName = hourlyWeather.symbolName
        temp = "\(hourlyWeather.temperature)"
    }
}
