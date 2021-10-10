//
//  TodayWeatherData.swift
//  DoINeedUmbrella WatchKit Extension
//
//  Created by Konstantin Loginov on 10/10/2021.
//

import Foundation

struct TodayWeatherData: Codable {
    let current: WeatherState
    let hourly: [WeatherState]
}

struct WeatherState: Codable {
    private let temp: Double
    private let weather: [Weather]
    
    var weatherCondition: WeatherCondition? {
        guard let state = weather.first else { return nil }
        return WeatherCondition(conditionId: state.id, cityName: state.description, temperature: temp)
    }
}
