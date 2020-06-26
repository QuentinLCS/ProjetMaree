//
//  MenuButtonView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MenuButtonView: View {
    
    private var colored:Bool
    private let home:Bool

    init(home: Bool = false, colored: Bool = true) {
        self.home = home
        self.colored = colored
    }
    
    var body: some View {
        NavigationLink(destination: MenuView()) {
            ButtonMainView(home: home, colored: colored)
        }
    }
}
