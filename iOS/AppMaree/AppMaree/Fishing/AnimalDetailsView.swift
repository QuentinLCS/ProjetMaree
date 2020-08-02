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
                    TitleView(title: "PÈCHE EN BATEAU", subTitle: "\(animal.name)")
                    
                    if (animal.imageName != "") {
                        Image(animal.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 200)
                    }
                        
                    Text(animal.describe()).padding(.horizontal, 20.0)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                    
                    ZStack {
                        DiagonalBackgroundView(a: .primaryColor)
                            .frame(minWidth: 1200)
                        
                        VStack (spacing: 0) {
                            if animal.taggingObligation != nil {
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
                                   Image("marquagePoisson")
                                       .resizable()
                                       .scaledToFit()
                                       .padding()
                                }
                                Spacer()
                            } else {
                                if animal.helpImage != nil {
                                    Text("Besoin d'aide ?")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                    
                                    Image(animal.helpImage!)
                                        .resizable()
                                        .scaledToFit()
                                        .padding()
                                } else {
                                    Text("Aucune aide disponible ...")
                                        .font(.system(size: 22))
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width)
                        .padding(.top, 20.0)
                        .padding(.bottom, 600)
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
