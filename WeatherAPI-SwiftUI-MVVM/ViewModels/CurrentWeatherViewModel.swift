//
//  CurrentWeatherViewModel.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/25/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import Combine

struct PresentableWeather: Identifiable {
    let name: String
    let weather: [CurrentWeatherResponse]
    var id: String {
        return name
    }
}

class CurrentWeatherViewModel: ObservableObject {
    
    private var cancellables: [AnyCancellable] = []

    // MARK: Input
    enum Input {
        case onAppear
        case onSearch(searchArray: [String])
    }
    func apply(_ input: Input) {
        switch input {
        case .onAppear: onAppearSubject.send(())
        case .onSearch(let searchArray):
            onSearchSubject.send(searchArray)
        }
    }
    private let onAppearSubject = PassthroughSubject<Void, Never>()
    private let onSearchSubject = PassthroughSubject<[String], Never>()
    
    // MARK: Output
    @Published private(set) var currentWeather = [PresentableWeather]()
    @Published var isErrorShown = false
    @Published var errorMessage = ""
    @Published var isLoading = false
    @Published private(set) var shouldShowIcon = false
    @Published var searchText: String {
        didSet(oldValue) {
            let allowingChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ,"
            let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
            if searchText.rangeOfCharacter(from: numberOnly) != nil {
                searchText = oldValue
            }
        }
    }
    
    private var searchArray: [String] {
        let arry = self.searchText.components(separatedBy: ",").map({ $0.trimmingCharacters(in: .whitespaces) })
        return arry
    }
    
    private var localWeather: [CurrentWeatherResponse] {
        didSet {
            if searchArray.count == localWeather.count {
                isLoading = false
                currentWeather = getPresentableData(localWeather)
            }
        }
    }
    
    private let responseSubject = PassthroughSubject<CurrentWeatherResponse, Never>()
    private let errorSubject = PassthroughSubject<APIServiceError, Never>()
    private let trackingSubject = PassthroughSubject<TrackEventType, Never>()
    
    private let apiService: APIServiceType
    private let trackerService: TrackerType

    init(apiService: APIServiceType = APIService(),
         trackerService: TrackerType = TrackerService(),
         experimentService: ExperimentServiceType = ExperimentService()) {
        self.apiService = apiService
        self.trackerService = trackerService
        self.localWeather = [CurrentWeatherResponse]()
        searchText = ""
        bindInputs()
        bindOutputs()
    }
    func validateSearchArray() {
        let array = searchArray
        let count = array.count
        if count > 2 && count < 8 {
            isLoading = true
            apply(.onSearch(searchArray: array)) //["Dubai", "Sharjah", "Abu Dhabi"]
        } else {
            errorMessage = "you can search minimum 3 and maximum 7 cities and all should be comma separated."
            isErrorShown = true
        }
    }
    private func bindInputs() {
//        let params = ["q": "", "appid": ""]
//        let request = CurrentWeatherRequest(params)
//        let responsePublisher = onAppearSubject
//            .flatMap { [apiService] _ in
//                apiService.response(from: request)
//                    .catch { [weak self] error -> Empty<CurrentWeatherResponse, Never> in
//                        self?.errorSubject.send(error)
//                        return .init()
//                }
//        }
        
        ///
        
        let responsePublisher = onSearchSubject
            .setFailureType(to: APIServiceError.self)
            .flatMap { (values) -> Publishers.MergeMany<AnyPublisher<CurrentWeatherResponse, APIServiceError>> in
            let tasks = values.map { (searchStr) -> AnyPublisher<CurrentWeatherResponse, APIServiceError> in
                let params = ["q": searchStr, "appid": Environment.API_KEY]
                let request = CurrentWeatherRequest(params)
                return APIService().response(from: request)
            }
            return Publishers.MergeMany(tasks)
        }.compactMap({ $0 }).share().sink(receiveCompletion: { (completion) in
            if case .failure(let error) = completion {
                self.errorSubject.send(error)
                self.isLoading = false
                print("Got error: \(error.localizedDescription)")
            }
        }) { (results) in
            print("Got users:")
          //  allUsers.map { print("\($0)") }
            self.localWeather.append(results)
           // self.responseSubject.send(results)
        }
        
        
        ///
//        let responseStream = responsePublisher
//            .share()
//            .subscribe(responseSubject)
        
        let trackingSubjectStream = trackingSubject
            .sink(receiveValue: trackerService.log)
        
        let trackingStream = onAppearSubject
            .map { .listView }
            .subscribe(trackingSubject)
        
        cancellables += [
            responsePublisher,
            trackingSubjectStream,
            trackingStream,
        ]
    }
    
    private func bindOutputs() {
//        let repositoriesStream = responseSubject
//            .map { $0 }
//            .assign(to: \.currentWeather, on: self)
        
//        let validator = $searchText.sink { (value) in
//            let allowingChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ ,"
//            let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
//            if let validString = value.rangeOfCharacter(from: numberOnly) {
//                self.searchText = String(value.dropLast())
//            }
//        }
        
        let errorMessageStream = errorSubject
            .map { error -> String in
                switch error {
                case .responseError: return "network error"
                case .parseError: return "parse error"
                }
            }
            .assign(to: \.errorMessage, on: self)
        
        let errorStream = errorSubject
            .map { _ in true }
            .assign(to: \.isErrorShown, on: self)
        
//        let showIconStream = onAppearSubject
//            .map { [experimentService] _ in
//                experimentService.experiment(for: .showIcon)
//            }
//            .assign(to: \.shouldShowIcon, on: self)
        
        cancellables += [
           // repositoriesStream,
            errorStream,
            errorMessageStream
            //,showIconStream
        ]
    }
    
    private func getPresentableData(_ weatherRes: [CurrentWeatherResponse]) -> [PresentableWeather] {
        var result = [PresentableWeather]()
        weatherRes.forEach { (weather) in
            result.append(PresentableWeather(name: weather.name ?? "", weather: [weather]))
        }
        return result
    }
}
