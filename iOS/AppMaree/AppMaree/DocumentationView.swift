//
//  DocumentationView.swift
//  AppMaree
//
//  Description : Cette page est celle permettant d'expliquer le fonctionnement de l'application. 
//  Il s'agit d'un guide d'utilisation simple et efficace en cas de problème d'ergonomie pour l'utilisateur.
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct DocumentationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            ScrollView {
                TitleView(title: "DOCUMENTATION")
                
                MainDataRow()
                
                StyledText("""
                PREMIÈRE LIGNE :
                Les valeurs 79 et 77 indiquent les coefficients de marées de pleine mer.

                SECONDE LIGNE :
                La première couleur indique les horaires de pleine mer et la deuxième couleur ceux de basse mer.
                
                TROISIEME LIGNE :
                Les horaires sur cette ligne sont fournis par le SHOM, le premier indique l'horaire d'ouverture et la deuxième la fermeture.

                DERNIÈRE LIGNE :
                La dernière ligne indique les hauteurs d'eau correspondant à la pleine mer ou basse mer.

                Prenons maintenant le cas où l'on veut:
                
                - 2 mètres d'eau sans pied de pilote au dessus de la porte ouverte (la saisie se fait dans les paramètres)
                - l'affichage des hauteurs d'eau à basse et pleine mer

                On a alors l'affichage suivant :
                """)
                    .style(.highlight(), ranges: { [$0.range(of: "PREMIÈRE LIGNE :")!, $0.range(of: "SECONDE LIGNE :")!, $0.range(of: "TROISIEME LIGNE :")!, $0.range(of: "DERNIÈRE LIGNE :")!]})
                    .style(.bold(), ranges: { [$0.range(of: "PREMIÈRE LIGNE :")!, $0.range(of: "SECONDE LIGNE :")!, $0.range(of: "TROISIEME LIGNE :")!, $0.range(of: "79 et 77")!, $0.range(of: "DERNIÈRE LIGNE :")!, $0.range(of: "première")!, $0.range(of: "deuxième")!]})
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 20.0)
                
                MainDataRow(day: Day(portes: [Porte(etat: "ouverture", heure: "06h53", estimatedHour: "7h12"),Porte(etat: "fermeture", heure: "13h40", estimatedHour: "13h08"),Porte(etat: "ouverture", heure: "19h23", estimatedHour: "20h07"),Porte(etat: "fermeture", heure: "02h00", estimatedHour: "1h58")], marees: [Maree(etat: "PM", heure: "04h22", hauteur: "2,1"),Maree(etat: "BM", heure: "10h03", hauteur: "9,25", coef: "79"),Maree(etat: "PM", heure: "16h46", hauteur: "1,95"),Maree(etat: "BM", heure: "22h27", hauteur: "8,95", coef: "77")], dateString: "01 JAN"))
                
                StyledText("""
                    NOUVELLE TROISIEME LIGNE :
                    Celle-ci indique alors l'heure donnée par le SHOM à partir de laquelle la porte ouvre (premier élément des parenthèses) ou ferme (second élément des parenthèses).
                    

                    NOUVELLE QUATRIÈME LIGNE :
                    Indique l'heure à partir de laquelle la hauteur d'eau est égale ou supérieure à 2 mètres (première couleur) et inférieur à 2 mètres (deuxième couleur). Ces horaires sont approximées et ne sont pas en provenance du SHOM.
                    """)
                        .style(.highlight(), ranges: { [$0.range(of: "NOUVELLE TROISIEME LIGNE :")!, $0.range(of: "NOUVELLE QUATRIÈME LIGNE :")!]})
                        .style(.bold(), ranges: { [$0.range(of: "NOUVELLE TROISIEME LIGNE :")!, $0.range(of: "NOUVELLE QUATRIÈME LIGNE :")!, $0.range(of: "première couleur")!, $0.range(of: "premier élément")!, $0.range(of: "première couleur")!, $0.range(of: "second élément")!]})
                        .padding(.bottom, 200.0)
                        .padding(.horizontal, 20.0)
                        .fixedSize(horizontal: false, vertical: true)
                
            }
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
    }
}
