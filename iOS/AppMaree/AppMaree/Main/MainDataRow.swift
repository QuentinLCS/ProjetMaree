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
    let colors:[[Color]] = [[Color.yellow, Color.green],[Color.blue, Color.red]]
    
    var body: some View {
        HStack(spacing: 0) {
            
            MainFontSizeView(data: self.day.dateString, isDate: true)
            
            ForEach(0..<4) { number in
                VStack(spacing: 0) {
                    
                    MainFontSizeView(data: self.day.marees[number].coef ?? "--")
                        
                    ZStack {
                        
                        self.colors[self.day.marees[number].etat == "PM" ? 1 : 0][0]
                        
                        MainFontSizeView(data: self.day.marees[number].heure)
                        
                    }
                    ZStack {
                        
                        self.colors[number % 2][1]

                        MainFontSizeView(data: self.day.portes[number].heure)
                        
                    }
                    
                    MainFontSizeView(data: self.day.marees[number].hauteur)
                   
                }
            }
        }.padding(.horizontal)
    }
}
