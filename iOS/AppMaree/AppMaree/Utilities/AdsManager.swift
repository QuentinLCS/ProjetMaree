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

func mappedAds() -> [String: [AdsManager]] {
    let ads: [AdsManager] = getAds()
    //Sort ads by their name and regroup them under the same category
    let map = ads.sorted(by: {$0.name < $1.name }).reduce(into: [String: [AdsManager]]()) { result, element in
        // Get the category of the current element
        let category = element.category
        // initialize an array with one element or add another element to the existing value
        result[category, default: []].append(element)
    }
    return map
}

func categoryArray() -> [String] {
    let ads: [AdsManager] = getAds()
    var array: [String] = []
    //Add in array every existing category
    for ad in ads {
        if !(array.contains(ad.category)) {
            array.append(ad.category)
        }
    }
    //Sort the category by name
    array.sort()
    return array
}
