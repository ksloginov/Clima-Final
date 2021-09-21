//
//  WeatherViewModel.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import Foundation
import CoreLocation

class WeatherViewModel: NSObject, ObservableObject {
    
    @Published var searchQuery: String = ""
    @Published var weatherCondtion: WeatherCondition?
    
    var latitude: CLLocationDegrees?
    var longitude: CLLocationDegrees?
    
    private let locationManager = CLLocationManager()
    private let dataService: DataService = DataService()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    func loadWeatherBySearchQuery(_ query: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if self?.searchQuery == query {
                self?.dataService.loadWeather(for: query) { result in
                    self?.receiveWeather(result: result)
                }
            }
        }
    }
    
    func loadLocalWeather(latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        guard let latitude = latitude, let longitude = longitude else { return }
        dataService.loadLocalWeather(latitude: latitude,
                                     longitude: longitude) { [weak self] result in
            self?.receiveWeather(result: result)
        }
    }
    
    private func receiveWeather(result: Result<WeatherCondition?, Error>) {
        switch result {
        case .success(let condition):
            DispatchQueue.main.async { [weak self] in
                self?.weatherCondtion = condition
            }
        case .failure(let error):
            print(error)
        }
    }
}

extension WeatherViewModel: CLLocationManagerDelegate {
    
    func requestLocation() {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            latitude = location.coordinate.latitude
            longitude = location.coordinate.longitude
            loadLocalWeather(latitude: latitude, longitude: longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
