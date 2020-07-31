//
//  CardView.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct CardView: View {
    
    @State var showMore: Bool = false
    
    let data: ListData
    
    var body: some View {
        VStack(spacing: 10) {
            Text(weatherHourString(dateHourString: data.dtTxt))
                .font(.headline)
                .fontWeight(.semibold)
                .fixedSize(horizontal: true, vertical: true)
            HStack {
                Text("\(Int(data.main.tempMin))")
                    .foregroundColor(.black)
                    .fixedSize(horizontal: true, vertical: true)
                Text("\(Int(data.main.temp))°C")
                    .fontWeight(.bold)
                    .font(.title)
                    .fixedSize(horizontal: true, vertical: true)
            }
            Text(data.weather.last?.description ?? "")
                .fixedSize(horizontal: true, vertical: true)
            
            if $showMore.wrappedValue {
                VStack {
                    Text("humidité: \(data.main.humidity)%")
                        .fixedSize(horizontal: true, vertical: true)
                    Text("vent: \(doShortDouble(value: data.wind.speed, decimals: 2))km/h (\(data.wind.deg)°)")
                        .fixedSize(horizontal: true, vertical: true)
                    Text("pression: \(data.main.pressure)")
                        .fixedSize(horizontal: true, vertical: true)
                }.animation(.easeInOut(duration: 0.5))
            }
            
            Button(action: { self.$showMore.wrappedValue.toggle() }) {
                if $showMore.wrappedValue {
                    Text("Masquer")
                        .fontWeight(.semibold)
                        .underline()
                } else {
                    Text("Voir plus")
                        .fontWeight(.semibold)
                        .underline()
                }
            }
            
        }.foregroundColor(.white)
    }
    
    func weatherHourString(dateHourString: String) -> String {
        return "\(dateHourString.split(separator: " ")[1].split(separator: ":")[0])H00"
    }
}

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"), Color("Primaire 2")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
    }
}
