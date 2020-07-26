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
    var agreement: Bool
    var water: String
    var fontSize: Double
    var colors: [CustomColor]
}

struct CustomColor: Codable {
    var red: Double
    var green: Double
    var blue: Double
}

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settingsVM : SettingsViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: "PARAMÈTRES")
                TextField("Votre tirant d'eau : (à partir de 1.6)", text: $settingsVM.settings.water)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color("Primaire 1"))
                    .keyboardType(.numberPad)
                
                MainDataRow(day: Day(portes: [Porte(etat: "ouverte", heure: "11h11"),Porte(etat: "ouverte", heure: "11h11"),Porte(etat: "ouverte", heure: "11h11"),Porte(etat: "ouverte", heure: "11h11")], marees: [Maree(etat: "ouverte", heure: "11h11", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "11h11", hauteur: "2,6"),Maree(etat: "ouverte", heure: "11h11", hauteur: "2,6", coef: "56"),Maree(etat: "ouverte", heure: "11h11", hauteur: "2,6", coef: "56")], dateString: "01 JAN"))
                
                Slider(value: $settingsVM.settings.fontSize, in: 1...3, step: 1)
                
                HStack {
                    ForEach(0..<4) { number in
                        NavigationLink(destination: SettingsColorEditorView(colorToEdit: number)) {
                            Circle()
                                //.foregroundColor(Color(red: self.$settingsVM.settings.colors[number].red.wrappedValue/255.0, green: self.$settingsVM.settings.colors[number].green.wrappedValue/255.0, blue: self.$settingsVM.settings.colors[number].blue.wrappedValue/255.0))
                        }
                    }
                }
                
                ButtonWindowView(isBack: true, presentation: presentationMode)
            }.padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
        .environmentObject(settingsVM)
    }
}
