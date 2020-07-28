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
    @EnvironmentObject var settings : SettingsViewModel
    
    var body: some View {
        NavigationView {
            Text("cc")
            /*
            ZStack {
                VStack(alignment: .leading) {
                    TitleView(title: "PARAMÈTRES")
                    
                    Text("Quel est votre tirant d'eau ?")
                       .fontWeight(.bold)
                       .padding(.top)
                    TextField("Votre tirant d'eau : (à partir de \(doShort(value: HAUTEUR_PORTE+0.1, decimals: 2)))", text: $settings.settings.water)
                        .padding(.bottom, 20.0)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .foregroundColor(Color("Primaire 1"))
                        .keyboardType(.numberPad)
                    
                    MainDataRow()
                    
                    Text("Taille du texte: ")
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    Slider(value: $settings.settings.fontSize, in: 1...3, step: 1)
                    
                    Text("Modifier les couleurs ?")
                        .fontWeight(.bold)
                        .padding(.top, 20)
                    
                    VStack {
                        HStack {
                            ForEach(0..<4) { number in
                                NavigationLink(destination: SettingsColorEditorView(colorToEdit: number)) {
                                    Circle()
                                        .foregroundColor(Color(red: self.$settings.settings.colors[number].red.wrappedValue, green: self.$settings.settings.colors[number].green.wrappedValue, blue: self.$settings.settings.colors[number].blue.wrappedValue))
                                }
                            }
                        }.frame(maxHeight: 100)
                        
                        Button(action: {
                           SettingsViewModel.resetAll()
                        }) {
                           Text("Réinitialiser l'application")
                               .fontWeight(.semibold)
                               .foregroundColor(Color.white)
                               .padding()
                               .background(Color.black)
                               .cornerRadius(30)
                               .shadow(radius: 10)
                        }
                        .padding(.top, 20.0)
                    }
                    Spacer()
                }.padding(.horizontal, 20)
                
                ButtonWindowView(isBack: true, presentation: presentationMode)
            }*/
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.top)
        .environmentObject(settingsVM)
    }
    
    func doShort(value: Double, decimals: Int) -> String {
        return String(format: "%0.\(decimals)f", value)
    }
}
