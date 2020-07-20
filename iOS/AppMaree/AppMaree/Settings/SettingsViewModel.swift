//
//  SettingsViewModel.swift
//  AppMaree
//
//  Created by unicaen on 17/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    static let agreementKey: String = "agreement"
    static let settingsKey: String = "settings"
    static let daysKey: String = "days"
    
    let defaults = UserDefaults.standard
    
    @Published var agreement: Bool = SettingsViewModel.exists(key: SettingsViewModel.agreementKey) ? try? PropertyListDecoder().decode(Bool.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.agreementKey) as! Data) : false {
        didSet {
            let encodedData = try? PropertyListEncoder().encode(self.agreement)
            defaults.set(encodedData, forKey: SettingsViewModel.agreementKey)
        }
    }
    
    @Published var settings: SavedSettings = SettingsViewModel.exists(key: SettingsViewModel.settingsKey) ? try? PropertyListDecoder().decode(SavedSettings.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.settingsKey) as! Data) : SavedSettings(water: "1.6", fontSize: 1.0) {
        
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
