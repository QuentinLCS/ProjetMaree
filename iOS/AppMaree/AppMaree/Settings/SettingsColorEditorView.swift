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
                //.foregroundColor(Color(red: $settingsVM.settings.colors[colorToEdit].red.wrappedValue/255.0, green: $settingsVM.settings.colors[colorToEdit].green.wrappedValue/255.0, blue: $settingsVM.settings.colors[colorToEdit].blue.wrappedValue/255.0))
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
    }
}
