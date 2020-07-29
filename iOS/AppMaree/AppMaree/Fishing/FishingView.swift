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
    let shellFishes: [Animal] = Animal.getShellFishes()
    
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
                                
                                HStack {
                                    Text("POISSONS")
                                        .font(.title)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                    Spacer()
                                }
                            }
                            .padding(.horizontal)
                        }
                        .frame(maxWidth: UIScreen.main.bounds.size.width)
                        .padding(.horizontal, 20)
                        
                        ZStack {
                            DiagonalBackgroundView()
                                .frame(minWidth: 1200)
                            
                            VStack(spacing: 20) {
                                Spacer()
                                //Affichage de tous les éléments
                                ForEach(0..<(fishes.count+1)/2) { row in // create number of rows
                                  HStack {
                                      ForEach(0..<2) { column in // create 2 columns
                                          
                                          self.makeFishCard(fishes: self.fishes,cell: self.getCell(row: row, column: column))
                                              
                                          }
                                      }
                                  }
                                  Spacer()
                              }
                        }
                        
                        HStack {
                            Spacer()
                            Text("CRUSTACÉS")
                                .font(.title)
                                .fontWeight(.bold)
                                .multilineTextAlignment(.trailing)
                                .padding()
                        }
                        .frame(maxWidth: UIScreen.main.bounds.size.width)
                        .padding(.horizontal, 20)
                        VStack(spacing: 20) {
                            //Affichage de tous les éléments
                            ForEach(0..<(shellFishes.count+1)/2) { row in // create number of rows
                                HStack {
                                    ForEach(0..<2) { column in // create 2 columns
                                       
                                        self.makeShellfishCard(shellFishes: self.shellFishes,cell: self.getCell(row: row, column: column))
                                        
                                    }
                                }
                            }
                        }
                        .padding(.bottom, 30.0)
                        
                        VStack {
                            Spacer()
                                
                            Text("Il manque une espèce ?")
                                .fontWeight(.bold)
                                .padding(.vertical)
                            Text("À propos > Nous contacter")
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
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.top)
        
    }
    
    func makeFishCard(fishes: [Animal], cell: Int) -> some View {
        if (cell < fishes.count) {
            return AnyView(NavigationLink(destination: AnimalDetailsView(animal: fishes[cell])) {
                ButtonFishView(backgroundColor: .white, name: fishes[cell].name, image: fishes[cell].imageName, size: fishes[cell].allowedSize)
                }.buttonStyle(PlainButtonStyle()))
        } else {
            return AnyView(ButtonFishView(backgroundColor: .white, name: "", image: ""))
        }
    }
    
    func makeShellfishCard(shellFishes: [Animal], cell: Int) -> some View {
        if (cell < shellFishes.count) {
            return AnyView(NavigationLink(destination: AnimalDetailsView(animal: shellFishes[cell])) {
                ButtonFishView(backgroundColor: .secondaryColor, name: shellFishes[cell].name, image: shellFishes[cell].imageName, size: shellFishes[cell].allowedSize)
            }.buttonStyle(PlainButtonStyle()))
        } else {
            return AnyView(ButtonFishView(backgroundColor: .secondaryColor, name: "", image: ""))
        }
    }
    
    func getCell (row: Int, column: Int) -> Int {
        return row * 2 + column
    }
}
