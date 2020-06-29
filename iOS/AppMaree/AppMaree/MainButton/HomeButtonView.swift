//
//  HomeButtonView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct HomeButtonView: View {
    
    private let colored:Bool
    private let isBack:Bool
    private let presentation:Binding<PresentationMode>?

    init(colored: Bool = true, isBack:Bool = true, presentation:Binding<PresentationMode>? = nil) {
        self.colored = colored
        self.isBack = isBack
        self.presentation = presentation
    }
      
    var body: some View {
        VStack {
            Spacer()
            if !isBack {
                NavigationLink(destination: MainView()) {
                    ButtonMainView(colored: colored)
                }
            } else {
                Button(action: {
                    self.presentation?.wrappedValue.dismiss()
                }) {
                    ButtonMainView(colored: false)
                }
            }
        }
    }
}
