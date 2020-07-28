//
//  TitleView.swift
//  AppMaree
//
//  Description : Il s'agit d'une fonction permettant l'affichage d'implifié des titres de haut de page.
//  Tout en restant conforme à la charte graphique. 
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    private let title:String
    private let titleColor:Color
    private let subTitle:String?
    private let subTitleColor:Color?
    private let backgroundColor:Color
    
    /*
    * Afficher un titre.
    * Aucun paramètre = Affiche "PORT-DIELETTE" en couleur bleu cyan.
    * Paramètres :
    * - title (permet de modifier le texte affiché)
    * - titleColor (permet de modifier la couleur du texte)
    */
    init() {
        self.title = "PORT-DIELETTE"
        self.titleColor = Color("Primaire 1")
        self.subTitle = "Association de plaisanciers"
        self.subTitleColor = Color("Primaire 1")
        self.backgroundColor = .white
    }
    
    init(title:String = "PORT-DIELETTE", titleColor:Color = Color("Primaire 1"), backgroundColor:Color = .white) {
        self.title = title
        self.titleColor = titleColor
        self.subTitle = nil
        self.subTitleColor = nil
        self.backgroundColor = backgroundColor
    }
    
    init(title:String, subTitle:String, backgroundColor:Color = .white ) {
        self.title = title
        self.titleColor = Color("Primaire 1")
        self.subTitle = subTitle
        self.subTitleColor = Color("Primaire 1")
        self.backgroundColor = backgroundColor
    }
    
    init(title:String, titleColor:Color, subTitle:String, subTitleColor:Color, backgroundColor:Color = .white) {
        self.title = title
        self.titleColor = titleColor
        self.subTitle = subTitle
        self.subTitleColor = subTitleColor
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
            .foregroundColor(backgroundColor).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(titleColor)
                if subTitle != nil {
                    Text(String(subTitle!))
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(subTitleColor)
                }
                Spacer()
            }
        }.frame(height: 50.0)
        
    }
}
