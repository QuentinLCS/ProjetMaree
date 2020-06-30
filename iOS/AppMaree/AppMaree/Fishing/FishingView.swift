//
//  FishingView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct FishingView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let fishes: [Animal] = Animal.getFishes()
    //let fishesCount: Int = fishesCount()
    let shellFishes: [Animal] = Animal.getShellFishes()
    //let shellFishesCount: Int = shellFishes.count()
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(alignment: .leading, spacing: 20) {
                TitleView(title: "PÊCHE EN BATEAU : LIMITES")
                
                Group {
                    Text("La pêche en bateau dispose de règles. Seules certaines tailles par espèces sont autorisées.\n\nPour obtenir davantage d'informations sur une espèce, cliquez dessus ! Certaines sont interdites à la pêche selon la période.")
                    
                    Text("POISSONS")
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                }.padding(.horizontal)
                    
                    ZStack {
                        DiagonalBackgroundView()
                            .padding()
                        
                        /*ForEach(0..<fishesCount) { number in*/
                            VStack {
                                HStack {
                                    Spacer()
                                    ButtonFishDetailsView(backgroundColor: .white, name: "BAR", image: "bar", size: 42.0)
                                    Spacer()
                                    ButtonFishDetailsView(backgroundColor: .white, name: "BAR", image: "bar", size: 42.0)
                                    Spacer()
                                }
                            }
                        //}
                    }
                    Spacer()
                }
                MenuButtonView(presentation: presentationMode)
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}

struct FishingView_Previews: PreviewProvider {
    static var previews: some View {
        FishingView()
    }
}
