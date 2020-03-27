//
//  ContentView.swift
//  SwiftUI-MVVM
//
//  Created by M.Waqas on 25/3/20.
//  Copyright © 2020  M.Waqas. All rights reserved.
//

import SwiftUI

struct ForecastListView : View {
    
    @ObservedObject var viewModel: ForecastViewModel

    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
               List {
                ForEach(self.viewModel.forecast) { forecast in
                    Section(header: Text(forecast.weekDay).bold()) {
                        ForEach(forecast.forecast) { item in
                            ForecastListRow(forecast: item)
                        }
                    }
                }
            }.listStyle(GroupedListStyle())
                .alert(isPresented: self.$viewModel.isErrorShown, content: { () -> Alert in
                    Alert(title: Text("Error"), message: Text(self.viewModel.errorMessage))
                })
            }
            .navigationBarTitle(Text(viewModel.forecast.first?.name != nil ? "Weather Forecast in \(viewModel.forecast.first?.name ?? "")" : ""))
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct RepositoryListView_Previews : PreviewProvider {
    static var previews: some View {
        ForecastListView(viewModel: .init())
    }
}
#endif
