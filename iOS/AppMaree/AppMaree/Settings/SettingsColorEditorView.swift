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
    @EnvironmentObject var settings : SettingsViewModel

    let colorToEdit: Int

    var body: some View {
        Text("cc")
        /*VStack {
            Circle()
                .foregroundColor(Color(red: $settings.settings.colors[colorToEdit].red.wrappedValue, green: $settings.settings.colors[colorToEdit].green.wrappedValue, blue: $settings.settings.colors[colorToEdit].blue.wrappedValue))
            
            Text("Rouge")
            Slider(value: $settings.settings.colors[self.colorToEdit].red, in: 0...1, step: 1/255)
            
            Text("Vert")
            Slider(value: $settings.settings.colors[self.colorToEdit].green, in: 0...1, step: 1/255)
            
            Text("Bleu")
            Slider(value: $settings.settings.colors[self.colorToEdit].blue, in: 0...1, step: 1/255)
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }*/
    }
}
