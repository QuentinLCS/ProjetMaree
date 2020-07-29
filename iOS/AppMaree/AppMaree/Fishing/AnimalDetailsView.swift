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
        NavigationView {
            ZStack {
                ScrollView {
                    TitleView(title: "PÈCHE EN BATEAU : LIMITES", subTitle: "\(animal.name)")
                        .padding(.bottom, 30.0)
                    
                    Text(animal.describe()).padding(.horizontal, 20.0)
                    
                    ZStack {
                        DiagonalBackgroundView(a: .primaryColor)
                        
                        VStack (spacing: 0) {
                            Text("Qu'est-ce qu'un marquage ?")
                                .font(.system(size: 22))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            
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
                            Spacer()
                        }
                        .padding(.top, 20.0)
                        .padding(.bottom, 250)
                    }
                }
                ButtonWindowView(isBack: true, presentation: presentationMode)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.vertical)
    }
}
