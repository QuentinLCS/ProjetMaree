//
//  MainView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI


struct MainView: View {
    
    @State private var showAd = false
    
    let ads = getAds()
    var currentImage = "APPD"
    
    var body: some View {
        NavigationView {
            ZStack {
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
