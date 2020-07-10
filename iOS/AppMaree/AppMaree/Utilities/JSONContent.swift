//
//  JSONContent.swift
//  AppMaree
//
//  Created by unicaen on 07/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

class JSONContent {
    static func JSONContent(filename: String) -> [Pub] {
        let url = Bundle.main.url(forResource: filename, withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let contents = try! decoder.decode([Pub].self, from: data)
        return contents
    }
}
