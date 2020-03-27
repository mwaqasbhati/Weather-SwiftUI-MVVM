//
//  LocationManager.swift
//  WeatherAPI-SwiftUI-MVVM
//
//  Created by Muhammad Zohaib Ehsan on 3/26/20.
//  Copyright © 2020 Muhammad Zohaib Ehsan. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationManager: NSObject, ObservableObject {
  
  private let locationManager = CLLocationManager()
  let objectWillChange = PassthroughSubject<String, Error>()
  private let geocoder = CLGeocoder()

  @Published var status: CLAuthorizationStatus? {
    willSet { objectWillChange.send() }
  }

  @Published var location: CLLocation? {
    willSet { objectWillChange.send() }
  }
  @Published var placemark: CLPlacemark?

  override init() {
    super.init()

    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestLocation()
  }

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
        
    }
}
