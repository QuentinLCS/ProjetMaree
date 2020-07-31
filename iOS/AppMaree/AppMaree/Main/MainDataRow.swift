//
//  MainDataRow.swift
//  AppMaree
//
//  Created by unicaen on 05/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainDataRow: View {
    
    @EnvironmentObject var settings : SettingsViewModel
    
    let day: Day
    
    init(day: Day = Day(portes: [Porte(etat: "ouverture", heure: "06h53"),Porte(etat: "fermeture", heure: "13h40"),Porte(etat: "ouverture", heure: "19h23"),Porte(etat: "fermeture", heure: "02h00")], marees: [Maree(etat: "PM", heure: "04h22", hauteur: "2,1"),Maree(etat: "BM", heure: "10h03", hauteur: "9,25", coef: "79"),Maree(etat: "PM", heure: "16h46", hauteur: "1,95"),Maree(etat: "BM", heure: "22h27", hauteur: "8,95", coef: "77")], dateShortString: "01 JAN")) {
        
        self.day = day
        
    }
    
    var body: some View {
        HStack(spacing: 0) {
            MainFontSizeView(data: self.day.dateShortString, isDate: true)
            
            ForEach(0..<4) { number in
                VStack(spacing: 0) {
                    
                    MainFontSizeView(data: self.day.marees[number].coef ?? "--")
                        
                    ZStack {
        
                        Color(red: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].red.wrappedValue, green: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].green.wrappedValue, blue: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].blue.wrappedValue)
                        
                        MainFontSizeView(data: self.day.marees[number].heure, color: self.$settings.settings.colors[mareeColor(day: self.day, number: number)].wrappedValue)
                        
                    }
                    
                    ZStack {
                        Color(red: self.$settings.settings.colors[doorColor(day: self.day, number: number)].red.wrappedValue, green: self.$settings.settings.colors[doorColor(day: self.day, number: number)].green.wrappedValue, blue: self.$settings.settings.colors[doorColor(day: self.day, number: number)].blue.wrappedValue)

                        MainFontSizeView(data: self.day.portes[number].heure, color: self.$settings.settings.colors[doorColor(day: self.day, number: number)].wrappedValue)
                        
                    }
                    
                    if self.day.portes[number > 1 ? number-2 : 0].estimatedHour != nil {
                        MainFontSizeView(data: self.day.portes[number].estimatedHour ?? "--")
                    }
                    
                    MainFontSizeView(data: self.day.marees[number].hauteur)
                   
                }
            }
        }.frame(maxHeight: 140)
        .padding(.horizontal)
        
    }
}

func mareeColor(day: Day, number: Int) -> Int {
    return day.marees[number].etat == "PM" ? 1 : 0
}

func doorColor(day: Day, number: Int) -> Int {
    return day.portes[number].etat == "ouverture" ? 2 : 3
}
