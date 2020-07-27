//
//  Pub.swift
//  AppMaree
//
//  Created by unicaen on 09/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation
import SwiftUI

struct AdsManager: Codable, Hashable {
    var name: String
    var file: String
    var weight: Int
    var category: String
}


// Retrieve all ads from the bundle
func getAdsWithWeight() -> [AdsManager] {
    
    var ads: [AdsManager] = []
    let contents = JSONContent.JSONAdsContent()
    
    for item in contents {
        for _ in 0..<item.weight {
            ads.append(item)
        }
    }
    return ads
}

func getAds() -> [AdsManager] {
    return JSONContent.JSONAdsContent()
}
