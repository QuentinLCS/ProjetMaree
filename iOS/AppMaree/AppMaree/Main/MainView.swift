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
    @State private var imageAd: String = ""
    
    @EnvironmentObject var settings: SettingsViewModel
    
    let ads = getAdsWithWeight()
    var days: [Day] = []
    let opacities:[Color] = [Color.white.opacity(1.0), Color.white.opacity(0.6)]

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
        if settingsVM.dayNumber == -1 { settingsVM.focusedDate = Date() }
    
    }
    
    var body: some View {
        let startListNumber: Int = $settings.dayNumber.wrappedValue < 1 ? $settings.dayNumber.wrappedValue : $settings.dayNumber.wrappedValue - 1
        
        return NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"),Color("Primaire 2"), Color("Primaire 3")]), startPoint: /*@START_MENU_TOKEN@*/.top/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.bottom/*@END_MENU_TOKEN@*/)
                
                // LISTE DES JOURS
                List {
                    ForEach(startListNumber ..< self.days.count) { number in
                        ZStack {
                            MainRowView(day: self.days[number])
                                .background(self.opacities[number % 2])
                            
                            NavigationLink(destination: DayView(day: self.days[number], weatherNumber: number - startListNumber - 1)) { EmptyView() }
                            .buttonStyle(PlainButtonStyle())
                        }
                        
                    }.listRowInsets(EdgeInsets())
                    
                    TitleView(title: "...", titleColor: .black ,backgroundColor: .clear)
                        .padding(.bottom, 200.0)
                }
                
                AdsView(showAd: $showAd, imageAd: $imageAd)
                
                ButtonWindowView(isBack: false, home: true)
            }
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: delay)
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.vertical)
        .environmentObject(settings)
        
    }
    
    // -------------------------- TEMPS ENTRE CHAQUE PUB --------------------------
    // C'est ici que le délai est indiqué. Modifiez la valeur afin de modifier le temps.
    // ----------------------------------------------------------------------------
    private func delay() {
        // Delay of 45 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 45) {
            self.showAd = true
            self.imageAd = self.randomAd()
            self.delay()
        }
    }
    
    func randomAd() -> String {
        return ads[Int.random(in: 0..<ads.count)].file
    }
}
