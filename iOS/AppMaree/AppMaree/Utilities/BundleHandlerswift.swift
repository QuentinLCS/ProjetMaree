//
//  BundleContent.swift
//  AppMaree
//
//  Created by unicaen on 05/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

class BundleHandler {
    static func bundleContent(bundleName: String) -> [URL] {
        let fileManager = FileManager.default
        let bundleURL = Bundle.main.bundleURL
        let assetURL = bundleURL.appendingPathComponent("\(bundleName).bundle")
        var contents: [URL] = []
        do {
          contents = try fileManager.contentsOfDirectory(at: assetURL, includingPropertiesForKeys: [URLResourceKey.nameKey, URLResourceKey.isDirectoryKey], options: .skipsHiddenFiles)
        }
        catch let error as NSError {
          print(error)
        }
        return contents
    }
}
