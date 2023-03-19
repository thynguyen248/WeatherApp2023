//
//  WeatherDetailBuilder.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import CoreLocation
import SwiftUI

final class WeatherDetailBuilder {
    static func makeWeatherDetailView(withDate date: Date, locationManager: LocationManager) -> some View {
        let detailViewModel = WeatherDetailViewModel(locationManager: locationManager, date: date)
        let detailView = WeatherDetailView(viewModel: detailViewModel)
        return detailView
    }
}
