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
                TitleView(title: "SELECTIONNEZ UNE DATE")
                
                Text("Vous pouvez afficher les horaires d'une journée spécifique, postérieure à la date du jour.")
                
                DatePicker("", selection: self.$settingsVM.focusedDate, in: Date()...dateCreator(day: 31, month: 12), displayedComponents: .date)
                    .labelsHidden()
            }
            .padding(.horizontal, 20.0)
            
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

func dateCreator(day: Int, month: Int, year: Int? = nil) -> Date {
    let today = Date()
    var dateComponents = DateComponents()
    let userCalendar = Calendar.current
    
    dateComponents.day = day
    dateComponents.month = month
    dateComponents.year = year ?? userCalendar.component(.year, from: today)
    
    return userCalendar.date(from: dateComponents) ?? today
}
