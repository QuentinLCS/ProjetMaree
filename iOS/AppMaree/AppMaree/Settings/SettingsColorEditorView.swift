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

    @State private var red: Double = 0
    @State private var green: Double = 0
    @State private var blue: Double = 0
    
    let colorToEdit: Int
    
    init(colorToEdit: Int) {
        self.colorToEdit = colorToEdit
    }

    var body: some View {
        let color: CustomColor = CustomColor(red: $red.wrappedValue, green: $green.wrappedValue, blue: $blue.wrappedValue)
        
        return NavigationView {
            VStack {
                TitleView(title: "PARAMÈTRES", subTitle: "Couleur \(colorToEdit+1)")
                ZStack {
                    Color(red: self.$red.wrappedValue, green: self.$green.wrappedValue, blue: self.$blue.wrappedValue)
                    
                    VStack(spacing: 40) {
                        Spacer()
                        VStack(spacing: 0) {
                            Text("ROUGE")
                                .fontWeight(.bold)
                                .foregroundColor(contrastedTextColor(color: color))
                            Slider(value: $red, in: 0...1, step: 1/255)
                        }
                        
                        VStack(spacing: 0) {
                            Text("VERT")
                                .fontWeight(.bold)
                                .foregroundColor(contrastedTextColor(color: color))
                            Slider(value: $green, in: 0...1, step: 1/255)
                        }
                        
                        VStack(spacing: 0) {
                            Text("BLEU")
                                .fontWeight(.bold)
                                .foregroundColor(contrastedTextColor(color: color))
                            Slider(value: $blue, in: 0...1, step: 1/255)
                        }
                        
                        Button(action: {
                            self.$settings.settings.colors[self.colorToEdit].red.wrappedValue = self.$red.wrappedValue
                            self.$settings.settings.colors[self.colorToEdit].green.wrappedValue = self.$green.wrappedValue
                            self.$settings.settings.colors[self.colorToEdit].blue.wrappedValue = self.$blue.wrappedValue
                        } ) {
                            Text("VALIDER")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.green)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(radius: 10)
                        }
                        Spacer()
                        Spacer()
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
        .onAppear(perform: {
            self.$red.wrappedValue = self.$settings.settings.colors[self.colorToEdit].red.wrappedValue
            self.$green.wrappedValue = self.$settings.settings.colors[self.colorToEdit].green.wrappedValue
            self.$blue.wrappedValue = self.$settings.settings.colors[self.colorToEdit].blue.wrappedValue
        } )
    }
}
