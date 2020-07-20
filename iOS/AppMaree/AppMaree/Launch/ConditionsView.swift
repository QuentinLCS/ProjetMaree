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
    @ObservedObject var settingsVM = SettingsViewModel()
    
    var body: some View {
    
        VStack {
            TitleView()
                .padding(.bottom, 20)
            
            StyledText("""
            Les données affichées sur cette application sont issues du GUIDE IMPRIMÉ et distribué gratuitement. Elles ne sont qu'indicatives.

             Certaines ont été fournies par le SHOM, d'autres sont calculées. Les horaires sont en HEURE LÉGALE et ne prennent pas en compte les variations liées à la météorologie ou à des effets locaux particuliers. En aucun cas, elles ne peuvent être utilisées pour la navigation maritime.
            """)
                .style(.highlight(), ranges: { [$0.range(of: "Elles ne sont qu'indicatives.")!] })
                .style(.bold(), ranges: { [$0.range(of: "GUIDE IMPRIMÉ")!, $0.range(of: "HEURE LÉGALE")!, $0.range(of: "Elles ne sont qu'indicatives.")! ]})
                .font(.system(size: 20))
                .padding(.horizontal, 20)
            
            ZStack {
                DiagonalBackgroundView(a: .primaryColor)

                VStack(spacing: 0) {
                    // ---------------------------------- TEXTE 2 ----------------------------------
                    // Dédouanement des auteurs de l'application en cas d'erreur.
                    // -----------------------------------------------------------------------------
                    Text("L'association et les auteurs de cette application ne peuvent être tenus responsables d'incidents ou d'accidents engendrés par la lecture des informations de cette application.")
                    .font(.system(size: 18))
                        .padding([.leading, .bottom, .trailing], 20)
                        .padding(.top, 40)
                    
                    Text("J'accepte les conditions d'utilisation")
                        .bold()
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18))
                    
                    Button(action: {
                        self.$settingsVM.agreement.wrappedValue.toggle()
                    }) {
                        if self.$settingsVM.agreement.wrappedValue {
                            Text("NON")
                        } else {
                            Text("OUI")
                        }
                    }
                    
                    Text("Acceptation SHOM 2019 - 2021")
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                        .padding(.vertical, 20.0)
                    
                    Spacer()
                }

                ButtonWindowView(colored: false, isBack: true, presentation: presentationMode)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
