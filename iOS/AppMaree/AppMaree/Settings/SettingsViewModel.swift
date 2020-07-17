//
//  SettingsViewModel.swift
//  AppMaree
//
//  Created by unicaen on 17/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

class SettingsViewModel: ObservableObject {
    
    @Published var waterParameter: Double = UserDefaults.standard.double(forKey: "water") {
        didSet {
            UserDefaults.standard.set(self.waterParameter, forKey: "water")
        }
    }
    
    @Published var days: [Day] = UserDefaults.standard.array(forKey: "days") {
        didSet {
            UserDefaults.standard.set(self.days, forKey: "days")
        }
    }
    
    func exists(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
}
