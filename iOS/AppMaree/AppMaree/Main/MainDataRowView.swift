//
//  MainDataRowView.swift
//  AppMaree
//
//  Created by unicaen on 01/08/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainDataRowView: View {
    
    @EnvironmentObject var settings : SettingsViewModel
    
    let number: Int
    let day: Day
    
    var body: some View {
        VStack(spacing: 0) {
            MainFontSizeView(data: self.day.marees[number].coef ?? "--")
                
            ZStack {

                Color(red: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].red.wrappedValue, green: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].green.wrappedValue, blue: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].blue.wrappedValue)
                
                MainFontSizeView(data: self.day.marees[number].heure, color: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].wrappedValue)
                
            }
            
            ZStack {
                Color(red: self.$settings.settings.colors[doorColor(day: self.day, number: number)].red.wrappedValue, green: self.$settings.settings.colors[doorColor(day: self.day, number: number)].green.wrappedValue, blue: self.$settings.settings.colors[doorColor(day: self.day, number: number)].blue.wrappedValue)

                if self.day.portes[number > 1 ? number-2 : 0].estimatedHour != nil {
                    MainFontSizeView(data: self.day.portes[number].estimatedHour ?? "--")
                } else {
                    MainFontSizeView(data: self.day.portes[number].heure, color: self.$settings.settings.colors[doorColor(day: self.day, number: number)].wrappedValue)
                }
                
            }
            
            if self.day.portes[number > 1 ? number-2 : 0].estimatedHour != nil {
                MainFontSizeView(data: self.day.portes[number].heure, color: self.$settings.settings.colors[doorColor(day: self.day, number: number)].wrappedValue)
            }
            
            MainFontSizeView(data: self.day.marees[number].hauteur)
        }
    }
}
