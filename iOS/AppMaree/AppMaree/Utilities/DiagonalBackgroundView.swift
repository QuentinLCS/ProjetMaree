//
//  DiagonalView.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

enum DiagonalColorType: String {
    case primaryColor = "Primaire 1"
    case secondaryColor = "Primaire 2"
    case gradient = ""
}

struct DiagonalBackgroundView: View {
    private let color: DiagonalColorType
    
    init(color: DiagonalColorType = .secondaryColor) {
        self.color = color
    }
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [(color == DiagonalColorType.gradient || color == DiagonalColorType.primaryColor) ? Color("Primaire 1") : Color("Primaire 2"), (color == DiagonalColorType.gradient || color == DiagonalColorType.secondaryColor) ? Color("Primaire 2") : Color("Primaire 1")]), startPoint: .top, endPoint: .bottom)
            .padding(-20)
            .rotationEffect(Angle(degrees: -4))
    }
}

struct DiagonalView_Previews: PreviewProvider {
    static var previews: some View {
        DiagonalBackgroundView()
    }
}
