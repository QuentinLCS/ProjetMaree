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
    
    var weather: ListData
    var city: CityObject
    var dateString: String
    
    var body: some View {
        VStack(spacing: 20) {
            Text("\(dateString)\nà \(city.name)")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: true, vertical: true)
            
            VStack {
                Text("\(Int(weather.main.temp))°C")
                    .font(.system(size: 65))
                    .fontWeight(.heavy)
                    .fixedSize(horizontal: true, vertical: true)
                
                Text("min: \(Int(weather.main.tempMin))°C / max: \(Int(weather.main.tempMax))°C")
                    .fixedSize(horizontal: true, vertical: true)
            }
            
            Text((weather.weather.last?.description)!)
                    .fixedSize(horizontal: true, vertical: true)
            VStack {
                Text("Soleil:")
                    .fontWeight(.semibold)
                    .fixedSize(horizontal: true, vertical: true)
                
                Text("\(getSunHour(data: city.sunrise))h - \(getSunHour(data: city.sunset))h")
                    .fixedSize(horizontal: true, vertical: true)
            }
        }
        .foregroundColor(.white)
        .frame(width: height, height: height)
        .background(LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"), Color("Primaire 2"), Color("Primaire 3")]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(45)
    }
    
    func getSunHour(data: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(data))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: date)
    }
}
