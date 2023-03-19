//
//  WeatherDetailView.swift
//  WeatherApp2023
//
//  Created by Thy Nguyen on 3/19/23.
//

import SwiftUI

struct WeatherDetailView: View {
    @EnvironmentObject var router: Router
    @StateObject var viewModel: WeatherDetailViewModel
    
    var body: some View {
        ZStack {
            List {
                ForEach(viewModel.dataSource) { itemViewModel in
                    WeatherDetailItemView(itemViewModel: itemViewModel)
                }
            }
            .listStyle(PlainListStyle())
            if viewModel.isLoading {
                ProgressView()
            }
        }
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button {
            router.path.removeLast()
        } label: {
            Image(systemName: "chevron.left")
                .renderingMode(.template)
                .foregroundColor(.black)
                .imageScale(.large)
        })
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = WeatherDetailViewModel(locationManager: LocationManager(), date: Date())
        WeatherDetailView(viewModel: viewModel)
    }
}
