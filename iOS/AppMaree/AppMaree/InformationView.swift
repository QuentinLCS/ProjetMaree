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
        ZStack {
            ScrollView {
                TitleView(title: "PORT-DIELETTE", subTitle: "Association des plaisanciers")
                    .padding(.bottom, 30.0)
                
                VStack {
                    Text("L'Association des Plaisanciers de Port-Diélette vous souhaite la bienvenue sur son terrain de jeu !\n\nLes horaires de marée, ouverture/fermeture de la porte de la marina de Port-Diéette rythment notre loisir !\n\nNotre association regroupe environ 200 usagers du port.\n\n Nos objectifs, favoriser les rencontres entre plaisanciers, apporter de la convivialité sur les pontons, défendre les droits des usagers, et la pêche de loisir !\n\nNotre association est affiliée au Comité Départemental de la Pêche Maritime de Loisirs et à la Fédération Nationales des pêcheurs Plaisanciers et Sportifs de France.\n\nVous pouvez nous rejoindre ! Pour tous renseignements :\n\nTél. : 06 82 37 75 62\n\nAdresse e-mail : app.dielette@gmail.com\n\nSite internet : http://appd.eklablog.com\n\n")
                    .font(.system(size: 20))
                    
                    Text("Remerciements")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer().frame(height: 40)
                    
                    Text("L'application a été réalisée en 2020 dans le cadre d'un projet de fin d'étude par des étudiants du DUT informatique de l'IUT de Caen, Université Grand Ouest Normandie.\n\nLes auteurs sont : Chavas Nathan et Lechasles Quentin (iOS), , Danger Tristan, Leveziel Damien, Roussel Alexandre (Android).\n\nTuteur application & modèle initial : Jean-Luc Lamotte.")
                    .font(.system(size: 20))
                }
                .padding(.horizontal)
                
                
            }
            
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}

