//
//  SettingsViewModel.swift
//  AppMaree
//
//  Created by unicaen on 17/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    static let settingsKey: String = "settings"
    static let daysKey: String = "days"
    
    let defaults = UserDefaults.standard
    
    @Published var settings: SavedSettings = SettingsViewModel.exists(key: SettingsViewModel.settingsKey) ? try? PropertyListDecoder().decode(SavedSettings.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.settingsKey) as! Data) : SavedSettings(agreement: false, water: "1.6", fontSize: 16, colors: [CustomColor(red: 255, green: 245, blue: 0), CustomColor(red: 88, green: 175, blue: 255), CustomColor(red: 66, green: 255, blue: 97), CustomColor(red: 255, green: 115, blue: 115)]) {
        didSet {
            let encodedData = try? PropertyListEncoder().encode(self.settings)
            defaults.set(encodedData, forKey: SettingsViewModel.settingsKey)
        }
    }
    
    @Published var days: [Day]? = SettingsViewModel.exists(key: SettingsViewModel.daysKey) ? try? PropertyListDecoder().decode(Array<Day>.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.daysKey) as! Data) : nil {
            
        didSet {
            let encodedData = try? PropertyListEncoder().encode(self.days)
            defaults.set(encodedData, forKey: SettingsViewModel.daysKey)
        }
    }
    
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
