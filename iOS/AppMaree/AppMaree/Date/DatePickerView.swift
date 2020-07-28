//
//  DatePickerView.swift
//  AppMaree
//
//  Created by unicaen on 27/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct DatePickerView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settings: SettingsViewModel
    
    var body: some View {
        ZStack {
            VStack {
                TitleView(title: "SELECTIONNEZ UNE DATE")
                
                Text("Vous pouvez afficher les horaires d'une journée spécifique, postérieure à la date du jour dans la limite des dates disponibles sur l'application.")
                
                DatePicker("", selection: self.$settings.focusedDate, in: Date()...dateCreator(day: 31, month: 12), displayedComponents: .date)
                    .labelsHidden()
            }
            .padding(.horizontal, 20.0)
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
    }
}
