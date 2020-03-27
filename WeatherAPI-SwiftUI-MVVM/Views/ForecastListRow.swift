//
//  RepositoryListRow.swift
//  SwiftUI-MVVM
//
//  Created by M.Waqas on 25/3/20.
//  Copyright © 2020  M.Waqas. All rights reserved.
//

import Foundation
import SwiftUI

struct ForecastListRow: View {

    @State var forecast: Forecast?

    var body: some View {
        HStack(spacing: 10.0) {
            HStack() {
                Text(forecast?.time ?? "12:00").bold()
            }.background(Color.blue.opacity(0.5), alignment: .center)
            VStack(alignment: .leading, spacing: 5.0) {
                HStack(spacing: 5.0) {
                    Text("Description: ").bold()
                    Text(forecast?.weather?.first?.weatherDescription?.rawValue ?? "")
                }
                HStack(spacing: 5.0) {
                    Text("Temperature: ").bold()
                    Text("\(forecast?.main?.tempMin?.formattedCelcius ?? "0.0") L / \(forecast?.main?.tempMax?.formattedCelcius ?? "0.0") H")
                }
                HStack(spacing: 5.0) {
                    Text("Wind: ").bold()
                    Text(String(format: "%0.2f m / s", forecast?.wind?.speed ?? 0.0))
                }
            }
            }.background(Color.clear, alignment: .leading)
    }
}

#if DEBUG
struct RepositoryListRow_Previews : PreviewProvider {
    static var previews: some View {
        ForecastListRow(forecast: nil)
    }
}
#endif
