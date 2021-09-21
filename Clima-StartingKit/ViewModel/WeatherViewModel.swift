//
//  WeatherViewModel.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import Foundation

class WeatherViewModel: ObservableObject {
    
    @Published var searchQuery: String = "" {
        didSet {
            print("Did set: \(searchQuery)")
            let value = searchQuery
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                if self?.searchQuery == value {
                    self?.loadWeatherBySearchQuery()
                }
            }
        }
    }
    
    private let dataService: DataService = DataService()
    
    func loadWeatherBySearchQuery() {
        
    }
    
    func loadLocalWeather() {
        
    }
    
}
