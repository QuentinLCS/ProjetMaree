//
//  InformationView.swift
//  AppMaree
//
//  Created by unicaen on 15/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct InformationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    TitleView(title: "PORT-DIELETTE", subTitle: "Association des plaisanciers")
                        .padding(.bottom, 20.0)
                    
                    StyledText("""
                        L'Association des Plaisanciers de Port-Diélette vous souhaite la bienvenue sur son terrain de jeu !

                        Plus de 200 USAGERS du port nous ont rejoint !

                        Nos objectifs :
                        Favoriser les rencontres entre plaisanciers, apporter de la convivialité sur les pontons, défendre les droits des usagers et la pêche de loisir !

                        Notre association est affiliée au Comité Départemental de la Pêche Maritime de Loisirs et à la Fédération Nationales des pêcheurs Plaisanciers et Sportifs de France.
                        """)
                        .style(.highlight(), ranges: { [$0.range(of: "Plus de 200 USAGERS")!]})
                        .style(.bold(), ranges: { [$0.range(of: "200 USAGERS")!, $0.range(of: "Nos objectifs :")!,  $0.range(of: "Comité Départemental de la Pêche Maritime de Loisirs")!, $0.range(of: "Fédération Nationales des pêcheurs Plaisanciers et Sportifs")! ]})
                        .padding([.leading, .bottom, .trailing], 20.0)
                    
                    VStack(alignment: .leading) {
                      
                        Text("NOUS CONTACTER")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20.0)
                        Spacer()
                    
                        ZStack {
                            DiagonalBackgroundView(de: .primaryColor, a: .secondaryColor)
                            
                            VStack(alignment: .leading) {
                                Text("ASSOCIATION :")
                                    .fontWeight(.bold)
                                    .padding(.top, 30.0)
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "http://appd.eklablog.com")!)
                                }) {
                                    StyledText("""
                                    - Tél. : 06 82 37 75 62
                                    - Adresse e-mail : app.dielette@gmail.com
                                    - Site internet : http://appd.eklablog.com
                                    """)
                                        .style(.bold(), ranges: { [$0.range(of: "Tél. :")!, $0.range(of: "Adresse e-mail :")!, $0.range(of: "Site internet :")!]})
                                }
                                
                                Text("DÉVELOPPEURS :")
                                    .fontWeight(.bold)
                                    .padding(.top, 30.0)
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://linkedin.com/in/quentin-lechasles")!)
                                }) {
                                    Text("- ")
                                    Text("LECHASLES Quentin.")
                                        .foregroundColor(Color.black)
                                    Text(" Plus d'infos ")
                                        .fontWeight(.bold)
                                        
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                                
                                Button(action: {
                                    UIApplication.shared.open(URL(string: "https://linkedin.com/in/nathan-chavas-3a6830182")!)
                                    
                                }) {
                                    Text("- ")
                                    Text("CHAVAS Nathan.")
                                        .foregroundColor(Color.black)
                                    Text(" Plus d'infos ")
                                        .fontWeight(.bold)
                                    Image(systemName: "chevron.right")
                                        .font(.caption)
                                }
                            }.padding(.bottom, 200)
                        }
                    }
                    .padding(.top, 30.0)
                    .foregroundColor(Color.white)
                    
                }

                ButtonWindowView(isBack: true, presentation: presentationMode)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.top)
    }
}

