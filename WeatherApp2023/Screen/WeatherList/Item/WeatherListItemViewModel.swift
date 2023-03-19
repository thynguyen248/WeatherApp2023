//
//  WeatherListItemViewModel.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/18/23.
//

import Foundation
import WeatherKit

struct WeatherListItemViewModel: Identifiable {
    let dateTime: Date
    let symbolName: String
    let lowTemp: String
    let highTemp: String
    
    var id: Date {
        return dateTime
    }
    
    var dateTimeString: String {
        return dateTime.toDayAbbrString()
    }
}

extension WeatherListItemViewModel {
    init(dailyWeather: DayWeather) {
        dateTime = dailyWeather.date
        symbolName = dailyWeather.symbolName
        lowTemp = "\(dailyWeather.lowTemperature.formatted())"
        highTemp = "\(dailyWeather.highTemperature.formatted())"
    }
}
