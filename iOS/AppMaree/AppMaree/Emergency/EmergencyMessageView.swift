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
            
            Text("196 - URGENCE")
                .font(.largeTitle)
                .foregroundColor(Color.red)
            
            if !$showMore.wrappedValue {
                HStack {
                    VStack {
                        Text("Cas MAYDAY: ")
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        Text("Un Homme à la mer ? Incendie / Explosion ? Voie d'eau, Abordage ? Navire désamparé à la dérive ? Échouement, Chavirement ? Navire en train de sombrer ? Abandon du navire ?")
                        
                        Spacer()
                    }
                    
                    VStack {
                        Text("Cas PAN-PAN: ")
                            .fontWeight(.bold)
                            .padding(.bottom)
                        
                        Text("Une avarie de propulsion ? Avarie de barre ? Hélice ou safran engagé ? Démâtage ? Demande d'avis médical ?")
                        
                        Spacer()
                    }
                }
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
            
            if $showMore.wrappedValue {
                Text("Mayday/Pan pan ! Mayday/Pan Pan ! Mayday/Pan pan ! Ici le bateau [TYPE ET NOM D'EMBARCATION] qui signale [NATURE DU SINISTRE] à la position [POSITION GPS ou AZIMUT/DISTANCE D'UN POINT REMARQUABLE]. [NOMBRE] à bord. Ici le bateau [TYPE ET NOM D'EMBARCATION]. Terminé.")
            }
            
            Spacer()
            
            
            
        }.padding(.horizontal, 20)
    }
}
