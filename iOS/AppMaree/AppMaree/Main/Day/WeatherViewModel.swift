//
//  WeeklyWeatherViewModel.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

import Combine
import SwiftUI

final class WeatherViewModel: ObservableObject {
    @Published var weekly: WeeklyWeather?
    
    init() {
        self.fetch()
    }
}

extension WeatherViewModel {
    func fetch(_ city: String = "Tréauville") {
        API.fetchWeather(by: city) {
            self.weekly = $0
        }
    }
    
    func gatherWeatherData() -> [[ListData]] {
        var result: [[ListData]] = [[]]
        let data = self.weekly?.list
        var i = 0, date: String = ""
        
        data!.forEach() { element in
            
            if result[i].isEmpty {
                result.append(Array())
                date = String(element.dtTxt.split(separator: " ")[0])
            }
            
            if element.dtTxt.contains(date) {
                result[i].append(element)
            } else {
                i += 1
            }
        }
        print(result.count)
        return result
    }
}
