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
    @EnvironmentObject var settingsVM: SettingsViewModel
    
    var body: some View {
        
        ZStack {
            VStack {
                DatePicker("", selection: self.$settingsVM.focusedDate, in: Date()..., displayedComponents: .date)
                    .labelsHidden()
            }
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
        

    }
}

func daysBetweenDates(date1: Date, date2: Date) -> Int {
    let calendar = Calendar.current
    
    let dateStart = calendar.startOfDay(for: date1)
    let dateStop = calendar.startOfDay(for: date2)
    
    return calendar.dateComponents([.day], from: dateStart, to: dateStop).day!
}
