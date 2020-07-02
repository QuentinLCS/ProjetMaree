//
//  adView.swift
//  AppMaree
//
//  Created by unicaen on 02/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct AdView: View {
    let presentation: Binding<PresentationMode>?
    private let image: String
    
    init(image: String, presentation: Binding<PresentationMode>? = nil ) {
        self.image = image
        self.presentation = presentation
    }
    
    var body: some View {
        VStack {
            Image(image).resizable().scaledToFit()
            .gesture(DragGesture().onEnded { value in
                self.presentation?.wrappedValue.dismiss()
            })
            Button("Close") {
                self.presentation?.wrappedValue.dismiss()
            }
            Spacer()
        }
        
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            AdView(image: "APPD")
        }
    }
}
