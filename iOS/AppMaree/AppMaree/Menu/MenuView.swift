//
//  ContentView.swift
//  AppMaree
//
//  Description : Il s'agit du menu coloré permettant de ridirigers vers les différentes autres pages.
//
//  Created by unicaen on 24/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TitleView()
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .center, spacing: 80, content: {
                        Spacer()
                        HStack {
                            Spacer()
                            ButtonMenuView(destination: .date)
                            Spacer()
                            ButtonMenuView(destination: .fishing)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            ButtonMenuView(destination: .documentation)
                            Spacer()
                            ButtonMenuView(destination: .settings)
                            Spacer()
                        }
                        ButtonWindowView(colored: false, presentation: presentationMode)
                    })
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
