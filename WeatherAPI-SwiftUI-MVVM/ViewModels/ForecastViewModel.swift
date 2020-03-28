//
//  ForecastViewModel.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import Combine

class ForecastViewModel: ObservableObject {
    
    // MARK: Input
    enum Input {
        case onAppear
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    
    private var cancellables: [AnyCancellable] = []
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let onGetLocSubject = PassthroughSubject<Void, Never>()
    private let responseSubject = PassthroughSubject<ForecastResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()

    // MARK: Output
    @Published private(set) var forecast = [PresentableForecast]()
    @Published var isErrorShown = false
    @Published var isLoading = true
    @Published var errorMessage = ""
    
    
    private let apiService: APIServiceType
    private let locationManager = LocationManager()

    // MARK: Initialzer
    init(apiService: APIServiceType = APIService()) {
        self.apiService = apiService
        getLocation()
        bindOutputs()
    }
    
    // MARK: Helper
    private func getLocation() {
        let subscriber = locationManager.objectWillChange.sink(receiveCompletion: { (completion) in
            switch completion {
                case .failure(let error):
                    self.errorSubject.send(error)
                case .finished: break
            }
        }) { (str) in
            
        }
                
        let placeholderSubs = locationManager.$placemark.sink { (placeMark) in
            if let name = placeMark?.locality {
                self.bindInputs(currentLoc: name)
                self.onGetLocSubject.send(())
            }
        }
        cancellables.append(subscriber)
        cancellables.append(placeholderSubs)
    }
    
    private func bindInputs(currentLoc: String) {
        let params = ["q": currentLoc, "appid": Environment.API_KEY]
        let request = ForecastRequest(params)
        let responsePublisher = onGetLocSubject
            .flatMap { [apiService] _ in
                apiService.response(from: request)
                    .catch { [weak self] error -> Empty<ForecastResponse, Never> in
                        self?.errorSubject.send(error)
                        return .init()
                }
        }
        
        let responseStream = responsePublisher
          //  .share()
            .subscribe(responseSubject)
                
        cancellables += [
            responseStream
        ]
    }
    
    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map {
                self.isLoading = false
                return ForecastViewModel.getPresentableData(($0))
            }
            .assign(to: \.forecast, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                error.localizedDescription
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map{ error -> Bool in
                self.isLoading = false
                return true
        }.receive(on: RunLoop.main)
            .assign(to: \.isErrorShown, on: self)
                
        cancellables += [
            repositoriesStream,
            errorStream,
            errorMessageStream
        ]
    }
    
    // MARK: Data Transformer
    private static func getPresentableData(_ forecastRes: ForecastResponse) -> [PresentableForecast] {
        var result = [PresentableForecast]()
        let forecast = forecastRes.list
        let days: [String] = forecast.map({ $0.weekDayString ?? "" }).removingDuplicates()
        days.forEach { (day) in
            let objects = forecast.filter({ $0.weekDayString == day })
            result.append(PresentableForecast(weekDay: day, name: forecastRes.city.name ?? "", forecast: objects))
        }
        return result
    }
}
