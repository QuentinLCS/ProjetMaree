//
//  ButtonMainView.swift
//  AppMaree
//
//  Description : Ceci est le corps, le design, la base du boutton principal présent sur toutes les pages.
// 
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ButtonMainView: View {
    
    private let colored:Bool
    private let home:Bool
    
    /*
    * Par défaut, home est à false.
    * home : permet de changer l'image au centre du bouton. Si "true" alors une maison s'affiche.
    * Sinon, une croix s'affiche. Ce cas est le plus courant. D'où ma valeur par défaut.
    */
    init(home: Bool = false, colored: Bool) {
        self.home = home
        self.colored = colored

    }
    
    var body: some View {
        // C'est ici que se trouve le bouton.
        Image(home ? "home" : colored ? "back" : "colored_back")
            .renderingMode(.original)
            .resizable()
            .aspectRatio(1, contentMode: .fit)
            .padding(25.0)
            .background(
             LinearGradient(gradient: Gradient(colors: [colored ? Color("Primaire 1") : Color.white, colored ? Color("Primaire 2") : Color.white]), startPoint: .top, endPoint: .bottom)
            )
            .clipShape(Circle())
            .frame(width: 100, height: 100, alignment: .bottom)
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            ButtonMainView(colored: true)
        }
    }
}
