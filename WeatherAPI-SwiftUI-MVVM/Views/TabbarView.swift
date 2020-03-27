//
//  TabbarView.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/26/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView {
            ForecastListView(viewModel: ForecastViewModel(apiService: APIService()))
                .tabItem {
                    Image(systemName: "calendar.circle")
                    Text("Forecast")
                }
            CurrentWeatherListView(viewModel: CurrentWeatherViewModel(apiService: APIService()))
            .tabItem {
                Image(systemName: "cloud.sun.fill")
                Text("Weather")
            }
        }
    }
}
