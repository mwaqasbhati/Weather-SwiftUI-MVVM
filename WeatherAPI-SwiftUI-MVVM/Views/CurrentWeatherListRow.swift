//
//  CurrentWeatherListRow.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/26/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import SwiftUI

struct CurrentWeatherListRow: View {
    
    @State var weather: CurrentWeatherResponse
    
    var body: some View {
        HStack(spacing: 10.0) {
            HStack() {
                Text(weather.dataTime).bold()
            }.background(Color.blue.opacity(0.5), alignment: .center)
            VStack(alignment: .leading, spacing: 5.0) {
                HStack(spacing: 5.0) {
                    Text("Description: ").bold()
                    Text(weather.weather.first?.weatherDescription?.rawValue ?? "")
                }
                HStack(spacing: 5.0) {
                    Text("Temperature: ").bold()
                    Text("\(weather.main.tempMin?.formattedCelcius ?? "0.0") L / \(weather.main.tempMax?.formattedCelcius ?? "0.0") H")
                }
                HStack(spacing: 5.0) {
                    Text("Wind: ").bold()
                    Text(String(format: "%0.2f m / s", weather.wind?.speed ?? 0.0))
                }
            }
            }.padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)).background(Color.clear, alignment: .leading)
    }
}

//struct CurrentWeatherListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CurrentWeatherListRow(forecast: Forecast())
//    }
//}
