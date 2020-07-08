//
//  DateView.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ServiceView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ButtonWindowView(presentation: presentationMode)
    }
}

struct ServiceView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceView()
    }
}
