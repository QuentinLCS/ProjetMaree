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
    
    @EnvironmentObject var settings: SettingsViewModel
    
    let ads = getAdsWithWeight()
    var days: [Day] = []
    let opacities:[Double] = [1.0, 0.6]

    init() {

        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().backgroundColor = .clear
        
        if !SettingsViewModel.exists(key: SettingsViewModel.daysKey) {
            let dataRetriver = MareeParser()
            dataRetriver.getData()
            settingsVM.days = dataRetriver.results
        }
        
        self.days = settingsVM.days!
        settingsVM.focusedDate = dateCreator(day: 1, month: 1)
    
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
                // LISTE DES JOURS
                List {
                    ForEach($settings.dayNumber.wrappedValue ..< self.days.count) { number in
                    
                        MainDataRow(day: self.days[number])
                            .background(Color.white.opacity(self.opacities[number % 2]))
                    }.listRowInsets(EdgeInsets())
                    TitleView(title: "...", titleColor: .black ,backgroundColor: .clear)
                        .padding(.bottom, 200.0)
                }
                
                // AFFICHAGE DE LA PUBLICITE test
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
            
        }
        .onAppear(perform: delay)
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.top)
        .environmentObject(settingsVM)
        
    }
    
    // -------------------------- TEMPS ENTRE CHAQUE PUB --------------------------
    // C'est ici que le délai est indiqué. Modifiez la valeur afin de modifier le temps.
    // ----------------------------------------------------------------------------
    private func delay() {
        // Delay of 45 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 45) {
            self.showAd = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            settingsVM.focusedDate = Date()
        }
    }
    
    func randomAd() -> String {
        return ads[Int.random(in: 0..<ads.count)].file
    }
}
