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
        ButtonWindowView(presentation: presentationMode)
    }
}

struct DocumentationView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationView()
    }
}
