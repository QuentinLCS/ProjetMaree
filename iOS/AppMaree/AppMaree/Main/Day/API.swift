//
//  API.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI
import SystemConfiguration


private let appid = "f4e691bf3877c853caf6df37da1d56bc"
private let baseUrlForWeeklyWeather = URL(string: "https://api.openweathermap.org/data/2.5/forecast")!



class API {
    class func fetchWeather(by city: String, onSuccess: @escaping (WeeklyWeather) -> Void ) {
        let query = ["q": "\(city)", "appid": appid, "units": "Metric", "lang": "fr"]

        guard let url = baseUrlForWeeklyWeather.withQueries(query) else {
            fatalError()
        }

        URLSession.shared.dataTask(with: url) { (data, res, err) in

            do {
                if let weather = JSONContent.JSONWeatherContent(data: data) {
                    DispatchQueue.main.async {
                        onSuccess(weather)
                    }
                }
            }

        }.resume()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        guard var component = URLComponents(url: self, resolvingAgainstBaseURL: true) else {
            fatalError()
        }
        
        component.queryItems = queries.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        return component.url
    }
}
