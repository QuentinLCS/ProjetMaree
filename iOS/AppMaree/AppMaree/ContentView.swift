//
//  ContentView.swift
//  AppMaree
//
//  Created by unicaen on 24/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Rectangle()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
                
                Text("PORT-DIELETTE")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Primaire 1"))
                
            }
            .frame(height: 50.0)
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 80, content: {
                    Spacer()
                    HStack {
                        Spacer()
                        ButtonMenuView(label: "Date", image: "clock")
                        Spacer()
                        ButtonMenuView(label: "Pêche", image: "fishing")
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        ButtonMenuView(label: "Manuel d'utilisation", image: "documentation")
                        Spacer()
                        ButtonMenuView(label: "Paramètres", image: "settings")
                        Spacer()
                    }
                    Spacer()
                    ButtonMainView(colored: false)
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
