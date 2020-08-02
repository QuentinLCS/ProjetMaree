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
    static let animalsKey: String = "animals"
    
    let defaults = UserDefaults.standard
    static let defaultSettings = SavedSettings(agreement: false, water: "", fontSize: 1, colors: [CustomColor(red: 1, green: 245/255, blue: 0), CustomColor(red: 88/255, green: 175/255, blue: 1), CustomColor(red: 66/255, green: 1, blue: 97/255), CustomColor(red: 1, green: 115/255, blue: 115/255)])
    
    @Published var settings: SavedSettings = SettingsViewModel.exists(key: SettingsViewModel.settingsKey) ? try? PropertyListDecoder().decode(SavedSettings.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.settingsKey) as! Data) : defaultSettings {
        didSet {
            if oldValue?.water != self.settings?.water {
                if let newWater = Double((self.settings?.water)!) {
                    if newWater >= HAUTEUR_PORTE + 0.1 {
                        calculHeureSelonTiranDEau(tirantDEau: newWater)
                    }
                }
            }
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
    
    var focusedDate: Date = Date() {
        didSet {
            self.dayNumber = daysBetweenDates(date1: dateCreator(day: 1, month: 1), date2: self.focusedDate)
        }
    }
    
    @Published var dayNumber: Int = -1
    
    static func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    var animals: [[Animal]]? = SettingsViewModel.exists(key: SettingsViewModel.animalsKey) ? try! PropertyListDecoder().decode(Array<Array<Animal>>.self, from: UserDefaults.standard.value(forKey: SettingsViewModel.animalsKey) as! Data) : nil {
        didSet {
            let encodedData = try? PropertyListEncoder().encode(self.animals)
            defaults.set(encodedData, forKey: SettingsViewModel.animalsKey)
        }
    }
    
    static func resetAll() {
        UserDefaults.standard.removeObject(forKey: settingsKey)
        UserDefaults.standard.removeObject(forKey: daysKey)
        settingsVM.settings = defaultSettings
        settingsVM.days = nil
    }
    
}
