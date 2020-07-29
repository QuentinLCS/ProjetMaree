//
//  ColorEditorView.swift
//  AppMaree
//
//  Created by unicaen on 19/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct SettingsColorEditorView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settings : SettingsViewModel

    let colorToEdit: Int

    var body: some View {
        let color: CustomColor = CustomColor(red: $settings.settings.colors[colorToEdit].red.wrappedValue, green: $settings.settings.colors[colorToEdit].green.wrappedValue, blue: $settings.settings.colors[colorToEdit].blue.wrappedValue)
        return NavigationView {
            VStack {
                TitleView(title: "PARAMÈTRES", subTitle: "Couleur \(colorToEdit+1)")
                ZStack {
                    Color(red: self.$settings.settings.colors[colorToEdit].red.wrappedValue, green: self.$settings.settings.colors[colorToEdit].green.wrappedValue, blue: self.$settings.settings.colors[colorToEdit].blue.wrappedValue)
                    
                    VStack(spacing: 40) {
                        
                        VStack {
                            Text("ROUGE")
                                .fontWeight(.bold)
                                .foregroundColor(contrastedTextColor(color: color))
                            Slider(value: $settings.settings.colors[self.colorToEdit].red, in: 0...1, step: 1/255)
                        }
                        
                        VStack {
                            Text("VERT")
                                .fontWeight(.bold)
                                .foregroundColor(contrastedTextColor(color: color))
                            Slider(value: $settings.settings.colors[self.colorToEdit].green, in: 0...1, step: 1/255)
                        }
                        
                        VStack {
                            Text("BLEU")
                                .fontWeight(.bold)
                                .foregroundColor(contrastedTextColor(color: color))
                            Slider(value: $settings.settings.colors[self.colorToEdit].blue, in: 0...1, step: 1/255)
                        }
                    }
                    .padding(.horizontal, 20.0)
                    
                    HomeButtonView(colored: false, isBack: true, presentation: presentationMode)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.vertical)
    }
}
