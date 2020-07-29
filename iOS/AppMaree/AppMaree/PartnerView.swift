//
//  DateView.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct PartnerView: View {
    @State private var showAd = false
    @State private var adFile = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let sortedAds: [String: [AdsManager]]
    let sortedCategory: [String]
    
    init() {
        self.sortedAds = mappedAds()
        self.sortedCategory = categoryArray()
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    TitleView(title: "PARTENAIRES")
                    
                    Text("L'association des plaisanciers de Port Dielette vous présente la liste de ses partenaires pour l'édition de l'annuaire des marées.")
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .bottom, .trailing], 20.0)
                    
                    ForEach(0..<sortedCategory.count) { category in // create number of rows
                        VStack {
                            Text(self.sortedCategory[category])
                                .font(.title)
                            
                                Spacer()
                                    .frame(height: 10)
                            ForEach(0..<self.sortedAds[self.sortedCategory[category]]!.count) { value in
                               
                                Button(action: {
                                    self.showAd = true
                                    self.adFile = self.sortedAds[self.sortedCategory[category]]![value].file
                                }) { Text(self.sortedAds[self.sortedCategory[category]]![value].name)
                                }
                            }
                        }
                        .padding(.bottom)
                    }
                    
                    Text("Merci à eux !")
                        .fontWeight(.bold)
                        .padding(.bottom, 200.0)
                }
                
                if showAd {
                    VStack {
                        Image(adFile)
                            .resizable().scaledToFit()
                            .modifier(DraggableModifier(direction: .horizontal, showAd: $showAd))
                        Spacer()
                    }
                }
                
                ButtonWindowView(presentation: presentationMode)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.top)
    }
}
