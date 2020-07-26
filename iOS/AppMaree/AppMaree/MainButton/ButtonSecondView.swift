//
//  ButtonSecondView.swift
//  AppMaree
//
//  Created by unicaen on 26/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ButtonSecondView: View {
    private let image: String
    
    init(image: String) {
        self.image = image
    }
    
    var body: some View {
        // C'est ici que se trouve le bouton.
        LinearGradient(gradient: Gradient(colors: [Color("Primaire 1"), Color("Primaire 2")]), startPoint: .top, endPoint: .bottom)
                .mask(Image(image)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(1, contentMode: .fit)
        ).frame(width: 40, height: 40, alignment: .bottom)
    }
}
