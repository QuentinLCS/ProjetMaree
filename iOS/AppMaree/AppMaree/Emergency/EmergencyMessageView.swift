//
//  EmergencyMessageView.swift
//  AppMaree
//
//  Created by unicaen on 27/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct EmergencyMessageView: View {
    
    @State private var showMore: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Vous recontrez un problème en mer ?")
                .fontWeight(.bold)
            
            Text("196 - SECOURS")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            
            if !$showMore.wrappedValue {
                HStack(spacing: 0) {
                    VStack {
                        Text("Cas MAYDAY: ")
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        Text("Un Homme à la mer ? Incendie / Explosion ? Voie d'eau ? Navire désamparé ? Abordé ? Échoué ? Chaviré ? Abandonné ?")
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("Cas PAN-PAN: ")
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        Text("Une avarie de propulsion ? Avarie de barre ? Hélice ou safran engagé ? Démâtage ? Demande d'avis médical ?")
                        
                        Spacer()
                    }
                }
            } else {
                Text("Mayday/Pan pan ! (x3) Ici le bateau [TYPE ET NOM D'EMBARCATION] qui signale [NATURE DU SINISTRE] à la position [POSITION GPS ou AZIMUT/DISTANCE D'UN POINT REMARQUABLE]. [NOMBRE INDIVIDUS] à bord. Ici le bateau [TYPE ET NOM D'EMBARCATION]. Terminé.")
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .padding()
                .background(Color.red.opacity(0.5))
                .cornerRadius(30)
            }
            
            Button(action: {
                self.$showMore.wrappedValue.toggle()
            }) {
                if $showMore.wrappedValue {
                    Text("Masquer les informations")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(30)
                } else {
                    Text("Montrer l'aide téléphonique")
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(30)
                }
            }
            
            Spacer()
            
            
            
        }.padding(.horizontal, 20)
    }
}
