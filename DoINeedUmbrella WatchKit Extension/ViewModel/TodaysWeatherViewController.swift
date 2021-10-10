//
//  TodaysWeatherViewController.swift
//  DoINeedUmbrella WatchKit Extension
//
//  Created by Konstantin Loginov on 10/10/2021.
//

import Foundation
import CoreLocation
import SwiftUI

enum State {
    case loading
    case error(Error)
    case value(needUmbrella: Bool, currentWeather: Weather)
}

class TodaysWeatherViewController: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    @Published var state: State = .loading
    
    private let locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            if let url = URL(string: Endpoint.todaysForecast(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude).url) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
