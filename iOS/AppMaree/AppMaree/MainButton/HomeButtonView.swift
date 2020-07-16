//
//  HomeButtonView.swift
//  AppMaree
//
//  Descrption : Cette vue est fait partie des deux possibilement appelées dans l'application
//  Celle-ci représente le bouton dans une page classique. Bouton rediirgeant vers la page principale.
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct HomeButtonView: View {
    
    private let colored:Bool
    private let isBack:Bool
    private let home:Bool
    private let presentation:Binding<PresentationMode>?

    init(colored: Bool = true, isBack:Bool = false, home: Bool = false, presentation:Binding<PresentationMode>? = nil) {
        self.colored = colored
        self.isBack = isBack
        self.presentation = presentation
        self.home = home
    }
      
    var body: some View {
        VStack {
            Spacer()
            if !isBack {
                if !home {
                    NavigationLink(destination: MainView()) {
                        ButtonMainView(colored: colored)
                    }
                } else {
                    NavigationLink(destination: MenuView()) {
                        ButtonMainView(home: home, colored: colored)
                    }
                }
            } else {
                Button(action: {
                    self.presentation?.wrappedValue.dismiss()
                }) {
                    ButtonMainView(colored: colored)
                }
            }
        }
    }
    
    struct MenuButton_Previews: PreviewProvider {
        static var previews: some View {
            HomeButtonView()
        }
    }
}
