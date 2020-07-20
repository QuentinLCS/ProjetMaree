//
//  SettingsView.swift
//  AppMaree
//
//  Description : Il s'agit de la page de paramètres. 
//
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct SavedSettings: Codable {
    var water: String
    var fontSize: Double
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var settingsVM = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: "PARAMÈTRES")
                TextField("Votre tirant d'eau : (à partir de 1.6)", text: $settingsVM.settings.water)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color("Primaire 1"))
                    .keyboardType(.numberPad)
                
                MainDataRow(day: Day(name: "mer", date: "01/01/2020", portes: [Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00"),Porte(etat: "ouverte", heure: "00h00")], marees: [Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "00h00", hauteur: "2,6", coef: "56")]))
                
                Slider(value: $settingsVM.settings.fontSize, in: 1...5, step: 1)
                ButtonWindowView(presentation: presentationMode)
            }.padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}
