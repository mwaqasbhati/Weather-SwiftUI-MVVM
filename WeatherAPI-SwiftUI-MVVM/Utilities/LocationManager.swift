//
//  LocationManager.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by M.Waqas on 3/26/20.
//  Copyright © 2020 M.Waqas. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
  
  //MARK: Properties
  
  private let locationManager = CLLocationManager()
  private let geocoder = CLGeocoder()
  let objectWillChange = PassthroughSubject<String, APIServiceError>()
  
  @Published var status: CLAuthorizationStatus = .notDetermined {
    didSet {
        if status == .denied || status == .restricted {
            objectWillChange.send(completion: .failure(APIServiceError.locationNotFound))
        }
    }
  }
  @Published var location: CLLocation? {
    didSet {
        if location == nil {
            objectWillChange.send(completion: .failure(APIServiceError.locationNotFound))
        }
    }
  }
  @Published var placemark: CLPlacemark?

  //MARK: Initializers
    
  override init() {
    super.init()

    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.requestLocation()
  }

   //MARK: Helper
    
  private func geocode() {
    guard let location = self.location else { return }
    geocoder.reverseGeocodeLocation(location, completionHandler: { (places, error) in
      if error == nil {
        self.placemark = places?[0]
      } else {
        self.placemark = nil
      }
    })
  }
}

//MARK: CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.status = status
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.location = location
        self.geocode()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        location = nil
    }
}
