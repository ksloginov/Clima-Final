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
    case value(needUmbrella: Bool, currentWeather: WeatherState)
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
                URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    
                    if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                        DispatchQueue.main.async { self?.state = .error(NetworkError.failedRequest) }
                        return
                    } else if let error = error {
                        DispatchQueue.main.async { self?.state = .error(error) }
                        return
                    }
                    
                    if let data = data {
                        do {
                            let decodedData = try JSONDecoder().decode(TodayWeatherData.self, from: data)
                            DispatchQueue.main.async {
                                self?.state = .value(needUmbrella: decodedData.hourly.prefix(10).contains(where: {$0.weatherCondition?.isRaining == true }), currentWeather: decodedData.current)
                            }
                            
                        } catch {
                            DispatchQueue.main.async { self?.state = .error(error) }
                            return
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        state = .error(error)
    }
}
