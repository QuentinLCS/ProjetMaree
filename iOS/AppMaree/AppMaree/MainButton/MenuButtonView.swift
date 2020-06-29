//
//  MenuButtonView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MenuButtonView: View {
    
    private let colored:Bool
    private let home:Bool
    private let isBack:Bool
    private let presentation:Binding<PresentationMode>?

    init(home: Bool = false, colored: Bool = true, isBack: Bool = true,  presentation:Binding<PresentationMode>? = nil) {
        self.home = home
        self.colored = colored
        self.isBack = isBack
        self.presentation = presentation
    }
    
    var body: some View {
        
        VStack {
            Spacer()
            if !isBack {
                NavigationLink(destination: MenuView()) {
                    ButtonMainView(home: home, colored: colored)
                }
            } else {
                Button(action: {
                    self.presentation?.wrappedValue.dismiss()
                }) {
                    ButtonMainView(home: home, colored: colored)
                }
            }
        }
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            MenuButtonView()
        }
    }
}
