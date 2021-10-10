//
//  ContentView.swift
//  DoINeedUmbrella WatchKit Extension
//
//  Created by Konstantin Loginov on 10/10/2021.
//

import SwiftUI

struct ToadaysWeatherView: View {
    
    @ObservedObject var viewModel = TodaysWeatherViewModel()
    
    var body: some View {
        Group {
            switch viewModel.state {
            case .error(let error):
                VStack {
                    Spacer()
                    Image(systemName: "xmark.octagon.fill")
                        .resizable()
                        .frame(width: 64.0, height: 64.0)
                    Text("An error occured: \(error.localizedDescription)")
                        .padding(.top, 8.0)
                    Spacer()
                }
            case .loading:
                ProgressView("Loading weather forecast")
            case .value(needUmbrella: let needUmbrella, currentWeather: let currentWeather):
                VStack {
                    Spacer()
                    if let currentWeather = currentWeather {
                        Image(systemName: currentWeather.conditionName)
                            .resizable()
                            .frame(width: 64.0, height: 64.0)
                        HStack {
                            Text(currentWeather.temperatureString)
                                .font(.system(size: 48.0, weight: .heavy, design: .rounded))
                            Text("°C")
                                .font(.system(size: 48.0, weight: .medium, design: .rounded))
                        }
                        .padding(.top, 8.0)
                    }
                    
                    Text(needUmbrella ? "Take umbrella" : "No rain today")
                    Spacer()
                }
            }
        }
        .padding()
    }
}

struct ToadaysWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ToadaysWeatherView()
    }
}
