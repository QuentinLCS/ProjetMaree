//
//  ContentView.swift
//  AppMaree
//
//  Description : Il s'agit du menu coloré permettant de ridirigers vers les différentes autres pages.
//
//  Si vous souhaitez ajouter un bouton dans ce menu, rendez-vous dans un premier temps dans le fichier "ButtonMenuView" puis rendez-vous au marqueur sur cette page.
//
//  Created by unicaen on 24/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: .topLeading, endPoint: .bottomTrailing)
                VStack(alignment: .center) {
                    // -------------------------- AFFICHAGE DES BOUTONS --------------------------
                    // C'est ici que sont affichés les boutons. Pour afficher le votre, utilisez la fonction
                    // comme utilisé ci-dessous et insérez-y votre nouvelle page. Concernant leur position,
                    // à vous de jouer avec leur ordre et les "Spacer()" ! Bon courage !
                    // ----------------------------------------------------------------------------
                    Spacer()
                    Spacer()
                    HStack {
                        Spacer()
                        ButtonMenuView(destination: .date)
                        Spacer()
                        ButtonMenuView(destination: .fishing)
                        Spacer()
                        // ButtonMenuView(destination: .nouvellePage)
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        ButtonMenuView(destination: .documentation)
                        Spacer()
                        ButtonMenuView(destination: .settings)
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        ButtonMenuView(destination: .partner)
                        Spacer()
                        ButtonMenuView(destination: .info)
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                }
                VStack {
                    TitleView()
                    Spacer()
                }
                HomeButtonView(colored: false, isBack: true, presentation: presentationMode)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.top)
    }
}
