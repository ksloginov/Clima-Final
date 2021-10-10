//
//  Endpoint.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import Foundation
import CoreLocation

enum Endpoint {
    private static let host = "https://api.openweathermap.org/data/2.5/"
    private static let APIKey = "9067ea08c6a8b9bce1efaf060de4246c"
    
    case localForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    case forecast(city: String)
    case todaysForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    
    var url: String {
        switch self {
        case .forecast(let city):
            let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? city
            return "\(Endpoint.host)weather?q=\(encodedCity)&appid=\(Endpoint.APIKey)&units=metric"
        case .localForecast(let latitude, let longitude):
            return "\(Endpoint.host)weather?lat=\(latitude)&lon=\(longitude)&appid=\(Endpoint.APIKey)&units=metric"
        case .todaysForecast(let latitude, let longitude):
            return "\(Endpoint.host)oneCall?lat=\(latitude)&lon=\(longitude)&exclude=minutely,daily&appid=\(Endpoint.APIKey)&units=metric"
        }
    }
}
