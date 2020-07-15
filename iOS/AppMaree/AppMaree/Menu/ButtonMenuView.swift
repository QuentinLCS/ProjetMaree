//
//  ButtonMenuView.swift
//  AppMaree
//
//  Description : Utilisé uniquement dans le menu, il s'agit ici des boutons du menu lui-même.
//  Cela permet de simplifier le code lourd du menu en indiquant les destination. Le code s'occupe du reste.
//
//  Si vous souhaitez ajouter une destination pour ajouter un bouton, suivez les étapes marquées.
//  ETAPE 1 : Créez un nouveau fichier allant accueillir le code de votre nouvelle page. (prendre exemple sur les autres)
//              Nommez la au nom désiré de votre page. Ce nom sera dans notre exemple "nouvellePage.swift".
//
//  ETAPE 2 : Ajoutez une image illustrant votre nouvelle page dans les assets. Peu importe où elle se trouve dans l'asset.
//              Nommez la astucieusement car le nom vous sera redemandé à la dernière étape. Dans l'exemple nous la nommerons "imagePage.???"
//
//  -----> PARCOUREZ CE FICHIER POUR LES AUTRES ETAPES.
//
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

// --------------------------------- ETAPE 3 ---------------------------------
// Ajouter un cas. "case <nom>" Cela permettra de simplifier et d'éviter les erreurs
// ---------------------------------------------------------------------------
enum Destination {
    case service
    case fishing
    case documentation
    case settings
    case info
    // case nouvellePage
}

struct ButtonMenuView: View {
    private let destination: Destination
    private var informations: (String, String) = ("", "")
    
    init(destination: Destination) {
        self.destination = destination
        self.informations = Informations(for: destination)
    }
    
    var body: some View {
        NavigationLink(destination: destinationFinder(for: destination)) {
            VStack {
                Image(informations.1)
                .resizable()
                .aspectRatio(contentMode: .fit)
                Spacer()
                Text(informations.0)
                .fontWeight(.bold)
            }
            .foregroundColor(Color.white)
            .multilineTextAlignment(.center)
            .frame(width: 100.0, height: 100.00)
        }
        .accentColor(Color.clear)
    }
    
    
    // --------------------------------- ETAPE 4 ---------------------------------
    // Décrivez quelle page doit ouvrir le cas ajouté. Cela dépend du nom de votre nouvelle page.
    // ---------------------------------------------------------------------------
    func destinationFinder(for destination: Destination) -> AnyView {
        switch destination {
            case .service:
                return AnyView(ServiceView())
            case .fishing:
                return AnyView(FishingView())
            case .documentation:
                return AnyView(DocumentationView())
            case .settings:
                return AnyView(SettingsView())
            case .info:
                return AnyView(InformationView())
            // case .nouvellePage:
            //  return AnyViews(nouvellePage())
        }
    }
    
    // --------------------------------- ETAPE 5 ---------------------------------
    // Indiquez ce qui doit être affiché. Le texte et l'image sans l'extension. (dans l'ordre)
    // Une fois cette étape finie, rendez-vous dans "MenuView" afin d'ajouter le bouton.
    // ---------------------------------------------------------------------------
    func Informations(for destination: Destination) -> (String, String) {
         switch destination {
             case .service:
                 return ("Services", "clock")
             case .fishing:
                 return ("Pêche", "fishing")
             case .documentation:
                 return ("Manuel d'utilisation", "documentation")
             case .settings:
                 return ("Paramètres", "settings")
            case .info:
                return ("À propos", "info")
             // case .nouvellePage:
             //  return ("nouvellePage", "imagePage")
        }
    }
}
