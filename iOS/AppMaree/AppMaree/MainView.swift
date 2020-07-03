//
//  MainView.swift
//  AppMaree
//
//  Description : Page principale contenant les tableaux avec horaires, les pubs, etc.
//
//  Si vous souhaitez AJOUTER ou MODIFIER des PUBS, rendez-vous : [ A MODIFIER ]
//  Afin de modifier le TEMPS ENTRE CHAQUE PUB : rendez-vous au marqueur sur cette page.
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI


struct MainView: View {
    
    // Variable dynamique entre les vues permettant d'afficher ou non la vue.
    @State private var showAd = false
    
    let ads = getAds()
    var currentImage = "APPD"
    
    var body: some View {
        NavigationView {
            ZStack {
                // AFFICHAGE DE LA PUBLICITE
                if showAd {
                    VStack {
                        Image(currentImage).resizable().scaledToFit()
                            .onDisappear(perform: delay)
                        .modifier(DraggableModifier(direction: .horizontal, showAd: $showAd))
                        Spacer()
                    }
                
                }
                ScrollView {
                    Text("Soon")
                }
                ButtonWindowView(isBack: false, home: true)
            }
        }.onAppear (perform: delay)
        .navigationBarHidden(true)
        .navigationBarTitle("Limites")
        .edgesIgnoringSafeArea(.all)
        
    }
    
    // -------------------------- TEMPS ENTRE CHAQUE PUB --------------------------
    // C'est ici que le délai est indiqué. Modifiez la valeur afin de modifier le temps.
    // ----------------------------------------------------------------------------
    private func delay() {
        // Delay of 45 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showAd = true
        }
    }
}

func getAds() -> [String] {
    var ads: [String] = []
    ads.append("cc")
    
    return ads
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
