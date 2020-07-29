//
//  conditionsView.swift
//  AppMaree
//
//  Created by unicaen on 20/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ConditionsView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var settings : SettingsViewModel
    
    @Binding var secondsLeft: Int

    var body: some View {
        NavigationView {
            ZStack {
                ScrollView {
                    TitleView()
                        .padding(.bottom, 20)
                    
                    StyledText("""
                    Les données affichées sur cette application sont issues du GUIDE IMPRIMÉ et distribué gratuitement. Elles ne sont qu'indicatives.

                     Certaines ont été fournies par le SHOM, d'autres sont calculées. Les horaires sont en HEURE LÉGALE et ne prennent pas en compte les variations liées à la météorologie ou à des effets locaux particuliers. En aucun cas, elles ne peuvent être utilisées pour la navigation maritime.
                    """)
                        .style(.highlight(), ranges: { [$0.range(of: "Elles ne sont qu'indicatives.")!] })
                        .style(.bold(), ranges: { [$0.range(of: "GUIDE IMPRIMÉ")!, $0.range(of: "HEURE LÉGALE")!, $0.range(of: "Elles ne sont qu'indicatives.")! ]})
                        .padding(.horizontal, 20)
                        .padding(.bottom, 20)
                    
                    ZStack {
                        DiagonalBackgroundView(a: .primaryColor)

                        VStack(spacing: 10) {
                            // ---------------------------------- TEXTE 2 ----------------------------------
                            // Dédouanement des auteurs de l'application en cas d'erreur.
                            // -----------------------------------------------------------------------------
                            Text("L'association et les auteurs de cette application ne peuvent être tenus responsables d'incidents ou d'accidents engendrés par la lecture des informations de cette application.")
                                .padding([.leading, .bottom, .trailing], 20)
                                .padding(.top, 50)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            Text("J'accepte les conditions d'utilisation")
                                .bold()
                                .multilineTextAlignment(.center)
                            
                            Button(action: {
                                self.$settings.settings.agreement.wrappedValue.toggle()
                            }) {
                                if self.$settings.settings.agreement.wrappedValue {
                                    Text("OUI")
                                } else {
                                    Text("NON")
                                }
                            }
                            .transition(AnyTransition.slide)
                            .animation(.default)
                            
                            Text("Acceptation SHOM 2019 - 2021")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .padding(.vertical, 20.0)

                        }
                        .padding(.bottom, 200.0)
                    }
                }
                
                ButtonWindowView(isBack: true, presentation: presentationMode)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.bottom)
        .onAppear(perform: {self.secondsLeft = -1})
        .onDisappear(perform: {self.secondsLeft = 3})
    }
}
