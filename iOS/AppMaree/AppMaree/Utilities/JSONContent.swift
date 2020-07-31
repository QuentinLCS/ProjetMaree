//
//  JSONContent.swift
//  AppMaree
//
//  Created by unicaen on 07/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

class JSONContent {
    static let decoder = JSONDecoder()
    static var dataDownloaded: Bool = true
    
    static func JSONAdsContent() -> [AdsManager] {
        let url = Bundle.main.url(forResource: "ads", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let contents = try! decoder.decode([AdsManager].self, from: data)
        return contents
    }
    
    static func JSONFishesContent() -> [[Animal]] {
        let url = Bundle.main.url(forResource: "fishes", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let contents = try! decoder.decode([[Animal]].self, from: data)
        return contents
    }
    
    static func JSONWeatherContent(data: Data?) -> WeeklyWeather? {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        var contents: WeeklyWeather? = nil
        if data != nil {
            contents = try! decoder.decode(WeeklyWeather.self, from: data!)
        }
        return contents
    }
}
