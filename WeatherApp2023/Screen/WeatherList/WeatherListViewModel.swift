//
//  WeatherListViewModel.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/18/23.
//

import Combine
import WeatherKit
import CoreLocation

final class WeatherListViewModel: ObservableObject {
    //Output
    @Published var dataSource: [WeatherListItemViewModel] = []
    @Published var error: AppError?
    @Published var isLoading = false
    
    private let service: WeatherService
    private let locationManager: LocationManager
    
    init(service: WeatherService = WeatherService.shared,
         locationManager: LocationManager = LocationManager()) {
        self.service = service
        self.locationManager = locationManager
        binding()
    }
    
    func binding() {
        locationManager.$authorizationStatus
            .dropFirst()
            .map { status -> AppError? in
                if status == .authorizedWhenInUse {
                    return nil
                }
                return AppError.locationService("Location service is not allowed")
            }
            .assign(to: &$error)
        
        dailyForecastPublisher
            .map { result -> [WeatherListItemViewModel] in
                if case .success(let dayWeathers) = result {
                    return dayWeathers.map { WeatherListItemViewModel(dailyWeather: $0) }
                }
                return []
            }
            .assign(to: &$dataSource)
        
        dailyForecastPublisher
            .map { result -> AppError? in
                if case .failure(let error) = result {
                    return error
                }
                return nil
            }
            .assign(to: &$error)
    }
    
    private var dailyForecastPublisher: AnyPublisher<Result<[DayWeather], AppError>, Never> {
        locationManager.$lastLocation
            .drop(while: { $0 == nil })
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = true
            })
            .await { [weak self] location in
                return await self?.fetchDailyForecast(location: location!) ?? .success([])
            }
            .receive(on: DispatchQueue.main)
            .share()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.isLoading = false
            })
            .eraseToAnyPublisher()
    }
    
    private func fetchDailyForecast(location: CLLocation) async -> Result<[DayWeather], AppError> {
        do {
            let forecast = try await service.weather(
                for: location,
                including: .daily)
            return .success(forecast.forecast)
        } catch {
            return .failure(AppError.weatherService(error.localizedDescription))
        }
    }
}
