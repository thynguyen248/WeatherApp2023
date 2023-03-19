//
//  WeatherDetailViewModel.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import Combine
import WeatherKit
import CoreLocation

final class WeatherDetailViewModel: ObservableObject {
    //Output
    @Published var dataSource: [WeatherDetailItemViewModel] = []
    @Published var error: AppError?
    @Published var isLoading = false
    
    private let service: WeatherService
    private let locationManager: LocationManager
    private let date: Date
    
    init(service: WeatherService = WeatherService.shared,
         locationManager: LocationManager = LocationManager(),
         date: Date) {
        self.service = service
        self.locationManager = locationManager
        self.date = date
        binding()
    }
    
    func binding() {
        hourlyForecastPublisher
            .map { result -> [WeatherDetailItemViewModel] in
                if case .success(let hourWeathers) = result {
                    return hourWeathers.map { WeatherDetailItemViewModel(hourlyWeather: $0) }
                }
                return []
            }
            .assign(to: &$dataSource)
        
        hourlyForecastPublisher
            .map { result -> AppError? in
                if case .failure(let error) = result {
                    return error
                }
                return nil
            }
            .assign(to: &$error)
    }
    
    private var hourlyForecastPublisher: AnyPublisher<Result<[HourWeather], AppError>, Never> {
        locationManager.$lastLocation
            .drop(while: { $0 == nil })
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .await { [weak self] location in
                guard let location = location else { return .success([]) }
                return await self?.fetchHourlyForecast(location: location) ?? .success([])
            }
            .receive(on: DispatchQueue.main)
            .share()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .eraseToAnyPublisher()
    }
    
    private func fetchHourlyForecast(location: CLLocation) async -> Result<[HourWeather], AppError> {
        do {
            let forecast = try await service.weather(
                for: location,
                including: .hourly(startDate: date, endDate: date.addDays(numberOfDays: 1)))
            return .success(forecast.forecast)
        } catch {
            return .failure(AppError.weatherService(error.localizedDescription))
        }
    }
}
