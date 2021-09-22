//
//  Endpoint.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import Foundation
import CoreLocation

enum Endpoint {
    private static let host = "https://api.openweathermap.org/data/2.5/weather"
    
    case localForecast(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    case forecast(city: String)
    
    var url: String {
        switch self {
        case .forecast(let city):
            let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? city
            return "\(Endpoint.host)?q=\(encodedCity)&appid=<insertkey>&units=metric"
        case .localForecast(let latitude, let longitude):
            return "\(Endpoint.host)?lat=\(latitude)&lon=\(longitude)&appid=<insertkey>&units=metric"
        }
    }
}
