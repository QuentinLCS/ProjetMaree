//
//  ButtonMenuView.swift
//  AppMaree
//
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

enum Destination {
    case date
    case fishing
    case documentation
    case settings
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
    
    func destinationFinder(for destination: Destination) -> AnyView {
        switch destination {
            case .date:
                return AnyView(DateView())
            case .fishing:
                return AnyView(FishingView())
            case .documentation:
                return AnyView(DocumentationView())
            case .settings:
                return AnyView(SettingsView())
        }
    }
    
    func Informations(for destination: Destination) -> (String, String) {
         switch destination {
             case .date:
                 return ("Date", "clock")
             case .fishing:
                 return ("Pêche", "fishing")
             case .documentation:
                 return ("Manuel d'utilisation", "documentation")
             case .settings:
                 return ("Paramètres", "settings")
        }
    }
}
