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
            VStack(spacing: 0) {
                TitleView()
                Spacer()
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                    VStack(alignment: .center, spacing: 80, content: {
                        Spacer()
                        // -------------------------- AFFICHAGE DES BOUTONS --------------------------
                        // C'est ici que sont affichés les boutons. Pour afficher le votre, utilisez la fonction
                        // comme utilisé ci-dessous et insérez-y votre nouvelle page. Concernant leur position, 
                        // à vous de jouer avec leur ordre et les "Spacer()" ! Bon courage !
                        // ----------------------------------------------------------------------------
                        HStack {
                            Spacer()
                            ButtonMenuView(destination: .service)
                            Spacer()
                            ButtonMenuView(destination: .fishing)
                            Spacer()
                            // ButtonMenuView(destination: .nouvellePage)
                        }
                        HStack {
                            Spacer()
                            ButtonMenuView(destination: .documentation)
                            Spacer()
                            ButtonMenuView(destination: .settings)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            ButtonMenuView(destination: .info)
                            Spacer()
                        }
                        ButtonWindowView(colored: false,isBack: true, presentation: presentationMode)
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
