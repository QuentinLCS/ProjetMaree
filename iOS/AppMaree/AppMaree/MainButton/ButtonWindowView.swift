//
//  ButtonWindowView.swift
//  AppMaree
//
//  Descrption : Cette vue est fait partie des deux possibilement appelées dans l'application
//  Celle-ci représente le bouton dans une page classique. Bouton rediirgeant vers le menu.
//
//  Created by unicaen on 30/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ButtonWindowView: View {
    
    private let colored: Bool
    private let isBack: Bool
    private let home: Bool
    private let presentation: Binding<PresentationMode>?

    init(colored: Bool = true, isBack: Bool = true, home: Bool = false, presentation: Binding<PresentationMode>? = nil) {
        self.colored = colored
        self.isBack = isBack
        self.presentation = presentation
        self.home = home
    }

    var body: some View {
        VStack {
            Spacer()
            ZStack {
                Rectangle()
                .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0),Color.white]), startPoint: .top, endPoint: .bottom))
                HomeButtonView(colored: colored, isBack: isBack, home: home, presentation: presentation)
                    .padding(.bottom, 100.0)
                    
            }
            .frame(height: 200.0)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            ButtonWindowView()
        }
    }
}
