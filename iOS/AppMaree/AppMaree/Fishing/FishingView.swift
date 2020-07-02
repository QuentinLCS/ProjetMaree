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
    
    let fishes: [Animal] = Animal.getFishes(bundleName: "Fish")
    let shellFishes: [Animal] = Animal.getFishes(bundleName: "Shellfish")
    
    var body: some View {
        NavigationView {
            ZStack {
                //Fenetre principale défilable
                ScrollView {
                    VStack {
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
                        VStack(spacing: 20) {
                            Spacer()
                            //Affichage de tous les éléments
                            ForEach(0..<(fishes.count+1)/2) { row in // create number of rows
                                HStack {
                                    ForEach(0..<2) { column in // create 2 columns
                                        self.makeFishCard(row: row, column: column)
                                        
                                    }
                                }
                            }
                            Spacer()
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(DiagonalBackgroundView())
                        
                        HStack {
                            Spacer()
                            Text("CRUSTACÉS")
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.trailing)
                                .padding()
                        }
                        VStack(spacing: 20) {
                            //Affichage de tous les éléments
                            ForEach(0..<(shellFishes.count+1)/2) { row in // create number of rows
                                HStack {
                                    ForEach(0..<2) { column in // create 2 columns
                                        self.makeShellfishCard(row: row, column: column)
                                    }
                                }
                            }
                            Spacer()
                        }
                        VStack {
                            Spacer()
                                
                            Text("Il manque une espèce ?")
                                .fontWeight(.bold)
                                .padding(.vertical)
                            Text("Paramètres > Nous contacter")
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                            Spacer()
                        }
                        .padding(.bottom, 300.0)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(DiagonalBackgroundView(de: .secondaryColor, a: .white))
                        
                    }
                }
                //Fenetre navigation
                
                ButtonWindowView(isBack: true, presentation: presentationMode)
                
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("Limites")
        .edgesIgnoringSafeArea(.all)
        
    }
    
    func makeFishCard(row: Int, column: Int) -> ButtonFishDetailsView {
        if (row * 2 + column < self.fishes.count) {
        return ButtonFishDetailsView(backgroundColor: .white, name: self.fishes[row * 2 + column].name, image: self.fishes[row * 2 + column].imageName, size: self.fishes[row * 2 + column].allowedSize, bundleName: "Fish")
        } else {
            return ButtonFishDetailsView(backgroundColor: .white, name: "", image: "", size: 0, bundleName: "")
        }
    }
    
    func makeShellfishCard(row: Int, column: Int) -> ButtonFishDetailsView {
        if (row * 2 + column < self.shellFishes.count) {
        return ButtonFishDetailsView(backgroundColor: .secondaryColor, name: self.shellFishes[row * 2 + column].name, image: self.shellFishes[row * 2 + column].imageName, size: self.shellFishes[row * 2 + column].allowedSize, bundleName: "Shellfish")
        } else {
            return ButtonFishDetailsView(backgroundColor: .secondaryColor, name: "", image: "", size: 0, bundleName: "")
        }
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
