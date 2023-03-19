//
//  WeatherListView.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/18/23.
//

import SwiftUI

struct WeatherListView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var locationManager: LocationManager
    @StateObject var viewModel: WeatherListViewModel
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack {
                List {
                    ForEach(viewModel.dataSource) { itemViewModel in
                        NavigationLink(value: itemViewModel.dateTime) {
                            WeatherListItem(itemViewModel: itemViewModel)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("10-days forecast", displayMode: .automatic)
                .navigationDestination(for: Date.self) { date in
                    WeatherDetailBuilder.makeWeatherDetailView(withDate: date, locationManager: locationManager)
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
        .errorAlert(isPresented: Binding<Bool>(
            get: { viewModel.error != nil },
            set: { _ in }
        ), error: viewModel.error)
    }
}

struct WeatherListView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeatherListViewModel()
        WeatherListView(viewModel: viewModel)
    }
}
