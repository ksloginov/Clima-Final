//
//  DataService.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import Foundation
import CoreLocation

struct DataService {
    
    func loadWeather(for city: String, completion: @escaping ((Result<WeatherCondition?, Error>) -> Void)) {
        guard let url = URL(string: Endpoint.forecast(city: city).url) else {
            completion(.failure(NetworkError.failedURL))
            return
        }
        
        performRequest(url, completion: completion)
    }
    
    func loadLocalWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping ((Result<WeatherCondition?, Error>) -> Void)) {
        guard let url = URL(string: Endpoint.localForecast(latitude: latitude, longitude: longitude).url) else {
            completion(.failure(NetworkError.failedURL))
            return
        }
        
        performRequest(url, completion: completion)
    }
    
    private func performRequest(_ url: URL, completion: @escaping ((Result<WeatherCondition?, Error>) -> Void)) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 400 {
                completion(.failure(NetworkError.failedRequest))
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    guard let id = decodedData.weather.first?.id else {
                        completion(.failure(NetworkError.failedJson))
                        return
                    }
                    
                    let name = decodedData.name
                    let temperature = decodedData.main.temp
                    
                    
                    let weatherCondition = WeatherCondition(conditionId: id,
                                                            cityName: name,
                                                            temperature: temperature)
                    completion(.success(weatherCondition))
                    
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
}
