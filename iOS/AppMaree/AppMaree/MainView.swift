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
import UIKit

struct MainView: View {
    
    // Variable dynamique entre les vues permettant d'afficher ou non la pub.
    @State private var showAd = false
    
    let ads = getAds()
    let days = getDays()
    
    var body: some View {
        NavigationView {
            ZStack {
                // AFFICHAGE DE LA PUBLICITE
                if showAd {
                    VStack {
                        Image(randomAd())
                            .resizable().scaledToFit()
                            .onDisappear(perform: delay)
                            .modifier(DraggableModifier(direction: .horizontal, showAd: $showAd))
                        Spacer()
                    }
                }
                //list placeholder
                List(days) { day in
                    MainDataRow(day: day)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 45) {
            self.showAd = true
        }
    }
    
    func randomAd() -> String {
        return ads[Int.random(in: 0..<ads.count)].file
    }
}


// Retrieve all days to show them in the scrollview
func getDays() -> [Day] {
    let dataRetriver = MareeParser()
    dataRetriver.getData()
    return dataRetriver.results
}

// Retrieve all ads from the bundle
func getAds() -> [Pub] {
    
    var ads: [Pub] = []
    let contents = JSONContent.JSONContent(filename: "pubs")
    
    for item in contents {
        for _ in 0..<item.weight {
            ads.append(item)
        }
    }
    return ads
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
