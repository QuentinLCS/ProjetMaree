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
    
    // Variable dynamique entre les vues permettant d'afficher ou non la pub.
    @State private var showAd = false
    @State var waterParameter: String = ""

    let ads = getAdsWithWeight()
    let days = getDays()
    let opacities:[Double] = [1.0, 0.6]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
                // LISTE DES JOURS
                ScrollView {
                    VStack {
                        ForEach(0..<self.days.count) { number in
                        
                            MainDataRow(day: self.days[number])
                                .background(Color.white.opacity(self.opacities[number % 2]))
                        }
                    }
                    TitleView(title: "FIN", titleColor: Color.white, backgroundColor: .clear)
                        .padding(.bottom, 200.0)
                }
                
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

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
