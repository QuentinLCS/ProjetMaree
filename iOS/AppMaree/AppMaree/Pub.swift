//
//  Pub.swift
//  AppMaree
//
//  Created by unicaen on 09/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation
import SwiftUI

struct Pub: Codable, Hashable {
    var name: String
    var file: String
    var weight: Int
    var category: String
}


// Retrieve all ads from the bundle
func getAdsWithWeight() -> [Pub] {
    
    var ads: [Pub] = []
    let contents = JSONContent.JSONContent(filename: "pubs")
    
    for item in contents {
        for _ in 0..<item.weight {
            ads.append(item)
        }
    }
    return ads
}

func getAds() -> [Pub] {
    return JSONContent.JSONContent(filename: "pubs")
}
