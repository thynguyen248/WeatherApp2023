//
//  DateExtension.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/18/23.
//

import Foundation

extension Date {
    func toDayAbbrString(format: String = "EEE") -> String {
        if Calendar.current.isDateInToday(self) {
            return "Today"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func timeIn24HourFormat() -> String {
            let formatter = DateFormatter()
            formatter.dateStyle = .none
            formatter.dateFormat = "HH:mm"
            return formatter.string(from: self)
        }
    
    func addDays(numberOfDays: Int) -> Date {
        let endDate = Calendar.current.date(byAdding: .day, value: numberOfDays, to: self)
        return endDate ?? Date()
    }
}
