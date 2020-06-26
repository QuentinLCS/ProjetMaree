//
//  HomeButtonView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct HomeButtonView: View {
    
    private var colored:Bool

    init(colored: Bool = true) {
        self.colored = colored
    }
      
    var body: some View {
        NavigationLink(destination: MainView()) {
            ButtonMainView(colored: colored)
        }
    }
}
