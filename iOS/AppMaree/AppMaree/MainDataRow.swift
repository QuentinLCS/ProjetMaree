//
//  MainDataRow.swift
//  AppMaree
//
//  Created by unicaen on 05/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainDataRow: View {
    var day: Day
    
    var body: some View {
        HStack {
            VStack {
                Text(verbatim: day.date)
            }
            Spacer()
            VStack {
                HStack {
                    Text(verbatim: day.marees[0].coef ?? "--")
                }
                HStack {
                    Text(verbatim: day.marees[0].heure)
                }
                HStack {
                    Text(verbatim: day.portes[0].heure)
                }
                HStack {
                    Text(verbatim: day.marees[0].hauteur)
                }
            }
            Spacer()
            VStack {
                HStack {
                    Text(verbatim: day.marees[1].coef ?? "--")
                }
                HStack {
                    Text(verbatim: day.marees[1].heure)
                }
                HStack {
                    Text(verbatim: day.portes[1].heure)
                }
                HStack {
                    Text(verbatim: day.marees[1].hauteur)
                }
            }
            Spacer()
            VStack {
                HStack {
                    Text(verbatim: day.marees[2].coef ?? "--")
                }
                HStack {
                    Text(verbatim: day.marees[2].heure)
                }
                HStack {
                    Text(verbatim: day.portes[2].heure)
                }
                HStack {
                    Text(verbatim: day.marees[2].hauteur)
                }
            }
            Spacer()
            VStack {
                HStack {
                    Text(verbatim: day.marees[3].coef ?? "--")
                }
                HStack {
                    Text(verbatim: day.marees[3].heure)
                }
                HStack {
                    Text(verbatim: day.portes[3].heure)
                }
                HStack {
                    Text(verbatim: day.marees[3].hauteur)
                }
            }
            Spacer()
        }
    }
}

struct MainDataRow_Previews: PreviewProvider {
    static var previews: some View {
        MainDataRow(day: Day(name: "mer", date: "01/01/2020", portes: [Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00")], marees: [Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56")]))
    }
}
