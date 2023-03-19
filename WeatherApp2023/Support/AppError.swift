//
//  AppError.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import Foundation

enum AppError: LocalizedError, Equatable {
    case weatherService(_ message: String)
    case locationService(_ message: String)
    case unknownError
    
    var message: String {
        switch self {
        case .weatherService(let message):
            return message
        case .locationService(let message):
            return message
        case .unknownError:
            return "Unknown error"
        }
    }
}
