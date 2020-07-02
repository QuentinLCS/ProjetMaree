//
//  SettingsView.swift
//  AppMaree
//
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            VStack {
                TitleView(title: "PARAMÈTRES")
                ZStack {
                    Text("...")
                }
                SliderView()
                SliderView()
                SliderView()
                ButtonWindowView(presentation: presentationMode)
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
