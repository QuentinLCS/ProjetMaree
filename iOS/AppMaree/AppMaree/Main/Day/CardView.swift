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
                .lineLimit(1)
            HStack {
                Text("\(Int(data.main.temp))°C")
                    .fontWeight(.bold)
                    .font(.title)
                    .lineLimit(1)
                Image(data.weather.last?.icon ?? "01d")
                Text("\(Int(data.main.tempMin))°C")
                    .font(.title)
                    .fontWeight(.light)
                    .lineLimit(1)
            }
            Text(data.weather.last?.description ?? "")
                .lineLimit(1)
            
            if $showMore.wrappedValue {
                VStack {
                    Text("humidité: \(data.main.humidity)%")
                        .lineLimit(1)
                    Text("vent: \(doShortDouble(value: data.wind.speed, decimals: 2))km/h (\(data.wind.deg)°)")
                        .lineLimit(1)
                    Text("pression: \(data.main.pressure)")
                        .lineLimit(1)
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
}

func weatherHourString(dateHourString: String) -> String {
    return "\(dateHourString.split(separator: " ")[1].split(separator: ":")[0])H00"
}

struct CardViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(LinearGradient(gradient: Gradient(colors: [Color("Primaire 2"), Color("Primaire 3")]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(20)
    }
}
