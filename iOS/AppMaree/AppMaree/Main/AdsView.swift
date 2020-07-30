//
//  AdsView.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct AdsView: View {
    
    @Binding var showAd: Bool
    @Binding var imageAd: String
    
    var body: some View {
        // AFFICHAGE DE LA PUBLICITE
        VStack {
            if showAd {
                Image($imageAd.wrappedValue)
                    .resizable().scaledToFit()
                    .modifier(DraggableModifier(direction: .horizontal, showAd: $showAd))

            } else {
                EmptyView()
            }
            Spacer()
        }
        .transition(AnyTransition.slide)
        .animation(.default)
    }
}
