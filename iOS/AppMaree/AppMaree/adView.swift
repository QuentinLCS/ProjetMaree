//
//  adView.swift
//  AppMaree
//
//  Created by unicaen on 02/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct AdView: View {
    @Binding var showAd: Bool
    let image: String
    
    var body: some View {
        VStack {
            Image(image).resizable().scaledToFit()
            .gesture(DragGesture().onEnded { value in
                self.showAd = false
            })
            Button("Close") {
                self.showAd = false
            }
            Spacer()
        }
        
    }
}
