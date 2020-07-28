//
//  DiagonalView.swift
//  AppMaree
//
//  Description : Fond coloré diagonal. 
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

// Toutes les couleurs supportées par ce fond.
enum DiagonalColorType: String {
    case primaryColor = "Primaire 1"
    case secondaryColor = "Primaire 2"
    case white = "White"
    case gradient = ""
}

struct DiagonalBackgroundView: View {
    private let startingColor: DiagonalColorType
    private let finalColor: DiagonalColorType
    
    // Par défaut, un dégradé est affiché pour le fond de cette forme.
    init(de sColor: DiagonalColorType = .primaryColor, a fColor: DiagonalColorType = .secondaryColor) {
        self.startingColor = sColor
        self.finalColor = fColor
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(startingColor.rawValue),Color(finalColor.rawValue)]), startPoint: .top, endPoint: .bottom)
            .padding(.horizontal, -20.0)
            .rotationEffect(Angle(degrees: -4))
    }
}
