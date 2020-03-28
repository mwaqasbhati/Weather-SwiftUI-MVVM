//
//  CurrentWeatherListView.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/26/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import SwiftUI

struct CurrentWeatherListView: View {
    
    @ObservedObject var viewModel: CurrentWeatherViewModel
    
    var body: some View {
        NavigationView {
            LoadingView(isShowing: $viewModel.isLoading) {
                    VStack(spacing: 10) {
                        Text("Note: You can search minimum 3 and maximum 7 cities and name should be comma separated.").bold()
                        HStack(spacing: 8) {
                            VStack() {
                                TextField("Enter cities name.", text: self.$viewModel.searchText, onEditingChanged: { (edit) in
                                    
                                }) {
                                  UIApplication.shared.endEditing()
                                }.keyboardType(.alphabet)
                                Rectangle().frame(height: 1.0)
                                    .padding(.horizontal, 0.0).foregroundColor(Color.gray)
                            }
                            Button(action: {
                                UIApplication.shared.endEditing()
                                self.viewModel.validateSearchArray()
                            }) {
                                Image(systemName: "magnifyingglass").padding().foregroundColor(.white).background(Color.blue)
                            }
                        }.padding()
                        List {
                            ForEach(self.viewModel.currentWeather) { weather in
                                Section(header: Text(weather.name)) {
                                    ForEach(weather.weather) { item in
                                         CurrentWeatherListRow(weather: item)
                                     }
                                }
                            }
                        }.listStyle(GroupedListStyle())
                            .alert(isPresented: self.$viewModel.isErrorShown, content: { () -> Alert in
                                Alert(title: Text("Error"), message: Text(self.viewModel.errorMessage))
                        })
                }.gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
            }
            .navigationBarTitle(Text("Current Weather"))
        }
        .onAppear(perform: { self.viewModel.apply(.onAppear) })
    }
}

#if DEBUG
struct CurrentWeatherListView_Previews : PreviewProvider {
    static var previews: some View {
       CurrentWeatherListView(viewModel: CurrentWeatherViewModel())
    }
}
#endif

