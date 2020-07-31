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
            
            HStack(spacing: 10) {
                Text("\(Int(weather.main.temp))°C")
                    .font(.system(size: 70))
                    .fontWeight(.heavy)
                    .lineLimit(1)
                
                Image(weather.weather.last?.icon ?? "01d")
                    .resizable()
                    .frame(width: 100, height: 100)
            }

            Text((weather.weather.last?.description)!)
                .lineLimit(1)
            
            VStack {
                Text("Soleil:")
                    .fontWeight(.semibold)
                    .lineLimit(1)
                
                Text("\(getSunHour(data: city.sunrise))h - \(getSunHour(data: city.sunset))h")
                    .lineLimit(1)
            }
        }
        .foregroundColor(.white)
        .frame(width: height * 0.8, height: height)
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
