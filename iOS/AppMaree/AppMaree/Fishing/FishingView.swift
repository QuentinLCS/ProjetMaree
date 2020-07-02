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
    
    let fishes: [(String, String, Double)] = Animal.getFishes()
    let shellFishes: [Animal] = Animal.getShellFishes()
    
    var body: some View {
        NavigationView {
            ZStack {
                //Fenetre principale défilable
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        TitleView(title: "PÊCHE EN BATEAU : LIMITES")
                            
                        Group {
                            Text("La pêche en bateau dispose de règles. Seules certaines tailles par espèces sont autorisées.\n\nPour obtenir davantage d'informations sur une espèce, cliquez dessus ! ")
                            + Text("Certaines sont interdites à la pêche selon la période.")
                                .bold()
                            
                        }
                        .padding(.horizontal)
                    }
                    HStack {
                        Text("POISSONS")
                            .font(.title)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                            .padding()
                        Spacer()
                    }
                    ZStack {
                        DiagonalBackgroundView()
                        
                        VStack(spacing: 20) {
                            
                            ForEach(0..<10) {
                                Text("Item \($0)")
                                    .foregroundColor(.white)
                                    .font(.largeTitle)
                                    .frame(width: 200, height: 200)
                                    .background(Color.red)
                            }
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                    
                }
                //Fenetre navigation
                
                ButtonWindowView(presentation: presentationMode)
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("Limites")
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct FishingView_Previews: PreviewProvider {
    static var previews: some View {
        FishingView()
    }
}

/*
 NavigationView {
     ZStack {
         VStack(alignment: .leading, spacing: 20) {
         TitleView(title: "PÊCHE EN BATEAU : LIMITES")
         
         Group {
             Text("La pêche en bateau dispose de règles. Seules certaines tailles par espèces sont autorisées.\n\nPour obtenir davantage d'informations sur une espèce, cliquez dessus ! ")
             + Text("Certaines sont interdites à la pêche selon la période.")
                 .bold()
             
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
     }
 }
 .navigationBarHidden(true)
 .navigationBarTitle("titre")
 .edgesIgnoringSafeArea(.all)
 */
