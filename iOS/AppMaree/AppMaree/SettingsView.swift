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

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var waterParameter: String
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: "PARAMÈTRES")
                TextField("Votre tirant d'eau : (à partir de 1.6)", text: $waterParameter)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(Color("Primaire 1"))
                SliderView()
                SliderView()
                SliderView()
                ButtonWindowView(presentation: presentationMode)
            }.padding(.horizontal)
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(waterParameter: "5")
    }
}
