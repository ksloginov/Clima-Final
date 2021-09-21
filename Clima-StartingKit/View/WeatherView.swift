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
        VStack {
            HStack(spacing: 15.0) {
                Button {
                    viewModel.loadLocalWeather()
                } label: {
                    Image(systemName: "location.circle.fill")
                        .resizable()
                        .frame(width: 48.0, height: 48.0)
                }
                
                TextField("Search for location", text: $viewModel.searchQuery)
                    .font(.title2)
            }
            .padding()
            .foregroundColor(Color("textColor"))
            
            Spacer()
        }
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
