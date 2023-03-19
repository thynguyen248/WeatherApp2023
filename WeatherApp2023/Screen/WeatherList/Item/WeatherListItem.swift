//
//  WeatherListItem.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/18/23.
//

import SwiftUI

struct WeatherListItem: View {
    let itemViewModel: WeatherListItemViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 24.0) {
            Text(itemViewModel.dateTimeString)
            Spacer()
            Image(systemName: itemViewModel.symbolName)
            Text(itemViewModel.lowTemp)
            Text(itemViewModel.highTemp)
        }
    }
}

struct WeatherListItem_Previews: PreviewProvider {
    static var previews: some View {
        let item = WeatherListItemViewModel(dateTime: Date(), symbolName: "cloud.sun.rain.fill", lowTemp: "20°", highTemp: "23°")
        WeatherListItem(itemViewModel: item)
    }
}
