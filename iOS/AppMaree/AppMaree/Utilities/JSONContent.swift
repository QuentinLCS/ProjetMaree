//
//  JSONContent.swift
//  AppMaree
//
//  Created by unicaen on 07/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

class JSONContent {
    static func JSONAdsContent() -> [AdsManager] {
        let url = Bundle.main.url(forResource: "ads", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let contents = try! decoder.decode([AdsManager].self, from: data)
        return contents
    }
    
    static func JSONFishesContent() -> [[Animal]] {
        let url = Bundle.main.url(forResource: "fishes", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let contents = try! decoder.decode([[Animal]].self, from: data)
        return contents
    }
}
