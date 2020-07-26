//
//  ColorEditorView.swift
//  AppMaree
//
//  Created by unicaen on 19/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct SettingsColorEditorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settingsVM : SettingsViewModel

    let colorToEdit: Int

    var body: some View {
        VStack {
            Circle()
                .foregroundColor(Color(red: $settingsVM.settings.colors[colorToEdit].red.wrappedValue, green: $settingsVM.settings.colors[colorToEdit].green.wrappedValue, blue: $settingsVM.settings.colors[colorToEdit].blue.wrappedValue))
            
            Text("Rouge")
            Slider(value: $settingsVM.settings.colors[self.colorToEdit].red, in: 0...1, step: 1/255)
            
            Text("Vert")
            Slider(value: $settingsVM.settings.colors[self.colorToEdit].green, in: 0...1, step: 1/255)
            
            Text("Bleu")
            Slider(value: $settingsVM.settings.colors[self.colorToEdit].blue, in: 0...1, step: 1/255)
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
    }
}
