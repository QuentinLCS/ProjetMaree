//
//  CurrentWeatherView.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct WeatherView: View {
    
    var height: CGFloat = 0
    
    var weather: ListData?
    var city: CityObject
    var dateString: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(dateString)\nà \(city.name)")
                .font(.title)
                .fontWeight(.bold)
            Text("\(Int(weather?.main.temp ?? 0))°C")
                .font(.system(size: 65))
                .fontWeight(.heavy)
            VStack {
                Text("\(weather?.weather.last?.description ?? "Inconnu")")
                Text("min: \(Int(weather?.main.tempMin ?? 0))°C / max: \(Int(weather?.main.tempMax ?? 0))")
            }
        }
        .foregroundColor(.white)
        .frame(width: height, height: height)
        .background(LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"), Color("Primaire 2"), Color("Primaire 3")]), startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}
