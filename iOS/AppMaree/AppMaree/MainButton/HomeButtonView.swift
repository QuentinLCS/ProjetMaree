//
//  HomeButtonView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct HomeButtonView: View {
    
    private let colored:Bool
    private let isBack:Bool

    init(colored: Bool = true, isBack:Bool = true) {
        self.colored = colored
        self.isBack = isBack
    }
      
    var body: some View {
        VStack {
            Spacer()
            NavigationLink(destination: MainView()) {
                ButtonMainView(colored: colored)
            }
        }
    }
}
