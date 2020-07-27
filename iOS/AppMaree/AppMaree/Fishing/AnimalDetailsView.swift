//
//  FishDetailsView.swift
//  AppMaree
//
//  Created by unicaen on 27/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct AnimalDetailsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let animal: Animal
    
    var body: some View {
        ZStack {
            VStack {
                TitleView(title: "PÈCHE EN BATEAU : LIMITES", subTitle: "\(animal.name) : \(animal.allowedSize)cm")
                    .padding(.bottom, 30.0)
                
                    Text(animal.describe()).padding(.horizontal, 20.0)
                
                ZStack {
                    DiagonalBackgroundView(a: .primaryColor)
                    
                    VStack {
                        TitleView(title: "Qu'est-ce qu'un marquage ?", titleColor: Color.white, backgroundColor: Color.clear)
                        if animal.helpImage != nil {
                           Image(animal.helpImage!)
                               .resizable()
                               .scaledToFit()
                               .padding()
                       } else {
                           Image("marquage-poisson")
                               .resizable()
                               .scaledToFit()
                               .padding()
                       }
                    }
                }
            }
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }.edgesIgnoringSafeArea(.bottom)
        
    }
}
