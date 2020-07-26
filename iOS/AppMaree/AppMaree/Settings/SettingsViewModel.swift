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
    static let defaultSettings = SavedSettings(agreement: false, water: "1.6", fontSize: 16, colors: [CustomColor(red: 1, green: 245/255, blue: 0), CustomColor(red: 88/255, green: 175/255, blue: 1), CustomColor(red: 66/255, green: 1, blue: 97/255), CustomColor(red: 1, green: 115/255, blue: 115/255)])
    
    @Published var settings: SavedSettings = SettingsViewModel.exists(key: SettingsViewModel.settingsKey) ? try? PropertyListDecoder().decode(SavedSettings.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.settingsKey) as! Data) : defaultSettings {
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
    
    static func resetAll() {
        UserDefaults.standard.removeObject(forKey: settingsKey)
        UserDefaults.standard.removeObject(forKey: daysKey)
        settingsVM.settings = defaultSettings
        settingsVM.days = nil
    }
    
}
