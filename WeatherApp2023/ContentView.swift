//
//  ContentView.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/17/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var router = Router()
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        WeatherListView(viewModel: WeatherListViewModel())
            .environmentObject(router)
            .environmentObject(locationManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
