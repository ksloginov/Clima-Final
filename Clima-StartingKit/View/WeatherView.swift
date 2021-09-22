//
//  WeatherView.swift
//  Clima-StartingKit
//
//  Created by Konstantin Loginov on 19.09.2021.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject var viewModel = WeatherViewModel()
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(spacing: 15.0) {
                Button {
                    viewModel.searchQuery = ""
                    viewModel.requestLocation()
                } label: {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 48.0, height: 48.0)
                }
                
                TextField("Search for location", text: $viewModel.searchQuery)
                    .font(.title2)
                    .onChange(of: viewModel.searchQuery) { newValue in
                        viewModel.loadWeatherBySearchQuery(newValue)
                    }
            }
            
            if let weatherCondtion = viewModel.weatherCondtion {
                VStack(alignment: .trailing) {
                    Image(systemName: weatherCondtion.conditionName)
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                    HStack {
                        Text(weatherCondtion.temperatureString)
                            .font(.system(size: 64.0, weight: .heavy, design: .rounded))
                        Text("°C")
                            .font(.system(size: 64.0, weight: .medium, design: .rounded))
                    }
                    
                    Text(weatherCondtion.cityName)
                        .font(.title)
                }
                .padding(.top, 15.0)
            } else {
                EmptyView()
            }
            
            Spacer()
        }
        .padding()
        .foregroundColor(Color("textColor"))
        .background(Image("background")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
