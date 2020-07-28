//
//  DateManager.swift
//  AppMaree
//
//  Created by unicaen on 27/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation

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
