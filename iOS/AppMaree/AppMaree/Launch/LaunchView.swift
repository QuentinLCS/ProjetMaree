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
    
    @ObservedObject var settingsVM = SettingsViewModel()
    
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
                    
                    $settingsVM.agreement.wrappedValue ? Text("true") : Text("false")
                    
                    // Bouton principal permettant de fermer cette page.
                    if $settingsVM.agreement.wrappedValue {
                        ButtonWindowView(isBack: false)
                    } else {
                        Text("Vous devez accepter les conditions d'utilisation de l'application pour l'utiliser !")
                            .foregroundColor(Color.red)
                            .multilineTextAlignment(.center)
                            .padding(.top)
                    }
                }
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("Limites")
        .edgesIgnoringSafeArea(.all)
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
