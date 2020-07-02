//
//  MainView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI


struct MainView: View {
    @Environment(\.presentationMode) var presentation: Binding<PresentationMode>
    @State private var showModal = false
    
    let ads = getAds()
    
    var body: some View {
        NavigationView {
            ZStack {
                if showModal {
                    AdView(image: "APPD", presentation: presentation)
                }
                ScrollView {
                    Text("Soon")
                }
                ButtonWindowView(isBack: false, home: true)
            }
        }.onAppear (perform: delay)
        
    }
    
    private func delay() {
        // Delay of 45 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showModal = true
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
