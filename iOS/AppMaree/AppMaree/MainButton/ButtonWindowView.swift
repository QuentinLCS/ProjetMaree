//
//  ButtonWindowView.swift
//  AppMaree
//
//  Created by unicaen on 30/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ButtonWindowView: View {
    
    private let colored:Bool
    private let isBack:Bool
    private let presentation:Binding<PresentationMode>?

    init(colored: Bool = true, isBack:Bool = false, presentation:Binding<PresentationMode>? = nil) {
        self.colored = colored
        self.isBack = isBack
        self.presentation = presentation
    }

    var body: some View {
        ZStack {
            Rectangle()
            .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0),Color.white]), startPoint: .top, endPoint: .bottom))
            HomeButtonView(colored: colored, isBack: isBack, presentation: presentation)
                .padding(.bottom, 70.0)
                
        }
        .frame(height: 200.0)
        
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            ButtonWindowView()
        }
    }
}
