//
//  ButtonFishDetailsView.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

enum FishButtonColorType: String {
    case primaryColor = "Primaire 1"
    case secondaryColor = "Primaire 2"
    case white = "White"
}

struct ButtonFishDetailsView: View {
    let backgroundColor: FishButtonColorType
    let name: String
    let image: String
    let size: Float
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(backgroundColor.rawValue))
            VStack {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(name)
                Text("\(size) cm")
            }
        }
    }
}

struct ButtonFishDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFishDetailsView(backgroundColor: .white, name: "BAR", image: "bar", size: 42.0)
    }
}
