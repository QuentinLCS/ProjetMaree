//
//  MainDataRow.swift
//  AppMaree
//
//  Created by unicaen on 05/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainDataRow: View {
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

struct MainDataRow_Previews: PreviewProvider {
    static var previews: some View {
        MainDataRow(day: Day(name: "mer", date: "01/01/2020", portes: [Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00")], marees: [Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56")]))
    }
}
