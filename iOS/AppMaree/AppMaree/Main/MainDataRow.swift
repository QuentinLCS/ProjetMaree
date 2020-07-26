//
//  MainDataRow.swift
//  AppMaree
//
//  Created by unicaen on 05/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainDataRow: View {
    
    @EnvironmentObject var settingsVM : SettingsViewModel
    
    let day: Day
    
    var body: some View {
        HStack(spacing: 0) {
            
            MainFontSizeView(data: self.day.dateString, isDate: true)
            
            ForEach(0..<4) { number in
                VStack(spacing: 0) {
                    
                    MainFontSizeView(data: self.day.marees[number].coef ?? "--")
                        
                    ZStack {
        
                        Color(red: self.$settingsVM.settings.colors[mareeColor(day: self.day, number: number)].red.wrappedValue, green: self.$settingsVM.settings.colors[mareeColor(day: self.day, number: number)].green.wrappedValue, blue: self.$settingsVM.settings.colors[mareeColor(day: self.day, number: number)].blue.wrappedValue)
                        
                        MainFontSizeView(data: self.day.marees[number].heure)
                        
                    }
                    
                    ZStack {
                        Color(red: self.$settingsVM.settings.colors[doorColor(day: self.day, number: number)].red.wrappedValue, green: self.$settingsVM.settings.colors[doorColor(day: self.day, number: number)].green.wrappedValue, blue: self.$settingsVM.settings.colors[doorColor(day: self.day, number: number)].blue.wrappedValue)

                        MainFontSizeView(data: self.day.portes[number].heure)
                        
                    }
                    
                    MainFontSizeView(data: self.day.marees[number].hauteur)
                   
                }
            }
        }.padding(.horizontal)
    }
}

func mareeColor(day: Day, number: Int) -> Int {
    return day.marees[number].etat == "PM" ? 1 : 0
}

func doorColor(day: Day, number: Int) -> Int {
    return day.portes[number].etat == "ouverture" ? 2 : 3
}
