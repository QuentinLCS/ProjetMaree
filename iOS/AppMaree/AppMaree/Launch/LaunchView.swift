//
//  LaunchView.swift
//  AppMaree
//
//  Description : Il s'agit de la page affichée au lancement de l'application. Celle contenant les informations nécessaires à la première ouverture.
//
//  Si vous souhaitez modifier le texte, rendez-vous aux marqueurs sous forme de commentaire plus bas.
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var settingsVM : SettingsViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack() {
                    TitleView()
                    // ---------------------------------- TEXTE 1 ----------------------------------
                    // Explication de la provenance des données ainsi que leur véracité.
                    // -----------------------------------------------------------------------------
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                    NavigationLink(destination: ConditionsView()) {
                        Text("Lire les conditions d'utilisation")
                        .underline()
                        .foregroundColor(Color("Primaire 1"))
                    }
                    
                    // Bouton principal permettant de fermer cette page.
                    if $settingsVM.settings.agreement.wrappedValue {
                        HomeButtonView(isBack: false).environmentObject(settingsVM)
                    } else {
                        Spacer()
                        Text("Vous devez accepter les conditions d'utilisation de l'application pour l'utiliser !")
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                        Spacer()
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.top)
        .environmentObject(settingsVM)
    }
}
    
extension TextStyle {
    static func highlight() -> TextStyle { .foregroundColor(Color("Primaire 1")) }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
