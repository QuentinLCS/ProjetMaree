//
//  MainDataRow.swift
//  AppMaree
//
//  Created by unicaen on 05/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainDataRow: View {
    
    @ObservedObject var settingsVM = SettingsViewModel()
    
    let day: Day
    let colors:[[Color]] = [[Color.yellow, Color.green],[Color.blue, Color.red]]
    
    var body: some View {
        HStack(spacing: 0) {
            
            Text(self.day.dateString)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.trailing)

            ForEach(0..<4) { number in
                VStack(spacing: 0) {
                    Text(verbatim: self.day.marees[number].coef ?? "--")
                    
                    ZStack {
                        self.colors[number % 2][0]
                        Text(verbatim: self.day.marees[number].heure)
                    }
                    ZStack {
                        self.colors[number % 2][1]
                        Text(verbatim: self.day.portes[number].heure)
                    }
                        
                    Text(verbatim: self.day.marees[number].hauteur)
                }
            }
        }.padding(.horizontal)
    }
}
