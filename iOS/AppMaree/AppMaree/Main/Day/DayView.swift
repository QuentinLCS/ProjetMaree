//
//  DayView.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct DayView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var weather = WeatherViewModel()
    
    @State private var selected = 0
    
    let day: Day
    let weatherNumber: Int
    
    var body: some View {
        let dayNum: Int = Int(day.date.split(separator: "/")[0])!
        let monthNum: Int = Int(day.date.split(separator: "/")[1])!
        let numberDays: Int = daysBetweenDates(date1: Date(), date2: dateCreator(day: dayNum, month: monthNum))
        let display: Bool = numberDays >= 0 && numberDays < 16
        
        return NavigationView {
            ZStack {
                
                if display {
                    GeometryReader { gr in
                        WeatherView(height: self.selected == 0 ? gr.size.height : gr.size.height * 0.50,weather: self.weather.weekly?.list[self.weatherNumber], city: self.weather.weekly!.city, dateString: self.day.dateString)
                            .animation(.easeInOut(duration: 0.5))
                    }
                    VStack {
                        Picker("", selection: $selected) {
                            Text("Simplifié").tag(0)
                            Text("Détaillé").tag(1)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        Spacer()
                    }
                } else {
                    LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"), Color("Primaire 2"), Color("Primaire 3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Text("Aucune estimation disponible pour ce jour.")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                }
                
                HomeButtonView(colored: false, isBack: true, presentation: presentationMode)
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.vertical)
    }
}

