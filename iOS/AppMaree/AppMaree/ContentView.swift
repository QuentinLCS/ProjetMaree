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
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
                
                Text("PORT-DIELETTE")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Primaire 1"))
                
            }
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        VStack {
                            Image("clock")
                            Text("DATE")
                        }
                        VStack {
                            Image("fishing")
                            Text("PECHE")
                        }
                    }
                    HStack {
                        VStack {
                            Image("documentation")
                            Text("DOCUMENTATION")
                        }
                        VStack {
                            Image("settings")
                            Text(/*@START_MENU_TOKEN@*/"SETTINGS"/*@END_MENU_TOKEN@*/)
                        }
                    }
                    ZStack {
                        Circle().foregroundColor(.white)
                        Image("colored_back")
                    }.frame(width: 100, height: 100)
                }
            }
        }
        
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
