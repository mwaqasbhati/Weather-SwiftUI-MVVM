//
//  ForecastViewModel.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import Combine

struct PresentableForecast: Identifiable {
    let weekDay: String
    let name: String
    let forecast: [Forecast]
    var id: String {
        return weekDay
    }
}

class ForecastViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []

    // MARK: Input
    enum Input {
        case onAppear
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let onGetLocSubject = PassthroughSubject<Void, Never>()

    // MARK: Output
    @Published private(set) var forecast: [PresentableForecast] = []
    @Published var isErrorShown = false
    @Published var isLoading = true
    @Published var errorMessage = ""
    @Published private(set) var shouldShowIcon = false
    
    private let responseSubject = PassthroughSubject<ForecastResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let trackingSubject = PassthroughSubject<TrackEventType, Never>()
    
    private let apiService: APIServiceType
    private let trackerService: TrackerType
    private var locationManager = LocationManager()

    init(apiService: APIServiceType = APIService(),
         trackerService: TrackerType = TrackerService(),
         experimentService: ExperimentServiceType = ExperimentService()) {
        self.apiService = apiService
        self.trackerService = trackerService
        
        getLocation()
    }
    private func getLocation() {
        let subscriber = locationManager.objectWillChange.sink { (value) in
            
        }
        
        let placeholderSubs = locationManager.$placemark.sink { (placeMark) in
            if let name = placeMark?.locality {
                self.bindInputs(currentLoc: name)
                self.bindOutputs()
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
            .share()
            .subscribe(responseSubject)
        
        let trackingSubjectStream = trackingSubject
            .sink(receiveValue: trackerService.log)
        
        let trackingStream = onAppearSubject
            .map { .listView }
            .subscribe(trackingSubject)
        
        cancellables += [
            responseStream,
            trackingSubjectStream,
            trackingStream,
        ]
    }
    
    private func bindOutputs() {
        let repositoriesStream = responseSubject
            .map {
                self.isLoading = false
                return self.getPresentableData(($0))
            }
            .assign(to: \.forecast, on: self)
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map{ error -> Bool in
                self.isLoading = false
                return true
            }
            .assign(to: \.isErrorShown, on: self)
        
//        let showIconStream = onAppearSubject
//            .map { [experimentService] _ in
//                experimentService.experiment(for: .showIcon)
//            }
//            .assign(to: \.shouldShowIcon, on: self)
        
        cancellables += [
            repositoriesStream,
            errorStream,
            errorMessageStream
            //,showIconStream
        ]
    }
    
    private func getPresentableData(_ forecastRes: ForecastResponse) -> [PresentableForecast] {
        var result = [PresentableForecast]()
        guard let forecast = forecastRes.list else { return result }
        let days: [String] = forecast.map({ $0.weekDayString ?? "" }).removingDuplicates()
        days.forEach { (day) in
            let objects = forecast.filter({ $0.weekDayString == day })
            result.append(PresentableForecast(weekDay: day, name: forecastRes.city?.name ?? "", forecast: objects))
        }
        return result
    }
}
