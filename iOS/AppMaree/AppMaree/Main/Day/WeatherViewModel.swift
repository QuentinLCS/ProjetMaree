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
        API.fetchCurrentWeather(by: city) {
            self.weekly = $0
        }
    }
}
