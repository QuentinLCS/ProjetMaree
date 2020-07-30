//
//  Weather.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

struct WeeklyWeather: Codable {
    let list: [ListData]
    let city: CityObject
}

struct ListData: Codable, Identifiable {
    let id = UUID()
    let dt: Int
    let main: TempObject
    let weather: [WeatherObject]
    let clouds: CloudObject
    let wind: WindObject
    let dtTxt: String
}

struct TempObject: Codable {
    let temp: Double
    let feelsLike: Double
    let tempMin: Double
    let tempMax: Double
    let pressure: Int
    let seaLevel: Int
    let grndLevel: Int
    let humidity: Int
}

struct WeatherObject: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct CityObject: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let timezone: Int
    let sunrise: Int
    let sunset: Int
    let population: Int
}

struct Coord: Codable {
    let lon, lat: Double
}

struct CloudObject: Codable {
    let all: Int
}

struct WindObject: Codable {
    let speed: Double
    let deg: Int
}
