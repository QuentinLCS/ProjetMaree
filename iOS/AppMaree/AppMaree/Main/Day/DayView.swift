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
    
    var height = UIScreen.main.bounds.height
    let day: Day
    let weatherNumber: Int
    
    
    var body: some View {
        let dayNum: Int = Int(day.date.split(separator: "/")[0])!
        let monthNum: Int = Int(day.date.split(separator: "/")[1])!
        let numberDays: Int = daysBetweenDates(date1: Date(), date2: dateCreator(day: dayNum, month: monthNum))
        let display: Bool = numberDays >= 0 && numberDays < 6 && weather.weekly != nil
        var midDay: Int = 0
        var weatherDataDayCount: Int = 0
        let weatherDataDay = display ? self.weather.gatherWeatherData()[self.weatherNumber] : nil
        
        if weatherDataDay != nil {
            weatherDataDayCount = weatherDataDay!.count
            midDay = weatherDataDayCount < 5 ? 0 : weatherDataDayCount / 2
        }
        
        return NavigationView {
            ZStack {
                
                if display {
                    VStack(spacing: 0) {
                        GeometryReader { gr in
                            WeatherView(height: self.selected == 0 ? gr.size.height : gr.size.height * 0.80,weather: weatherDataDay![midDay], city: self.weather.weekly!.city, dateString: self.day.dateString)
                                .animation(.easeInOut(duration: 0.5))
                                .shadow(radius: 30)
                                .animation(.easeInOut(duration: 0.5))
                        }
                        
                        WeatherDetailsView(listData: weatherDataDay!, value: selected, height: (self.height * 0.5))
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
                    
                    Text("Aucune donnée. \n\nVérifiez votre connexion internet ou sélectionnez un jour antérieur plus proche.")
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

