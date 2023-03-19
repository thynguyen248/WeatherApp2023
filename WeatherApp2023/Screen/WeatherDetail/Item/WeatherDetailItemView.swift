//
//  WeatherDetailItemView.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import SwiftUI

struct WeatherDetailItemView: View {
    let itemViewModel: WeatherDetailItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 24.0) {
            Text(itemViewModel.timeString)
            Spacer()
            Image(systemName: itemViewModel.symbolName)
            Text(itemViewModel.temp)
        }
    }
}

struct WeatherDetailItemView_Previews: PreviewProvider {
    static var previews: some View {
        let item = WeatherDetailItemViewModel(dateTime: Date(), symbolName: "cloud.sun.rain.fill", temp: "20°")
        WeatherDetailItemView(itemViewModel: item)
    }
}
