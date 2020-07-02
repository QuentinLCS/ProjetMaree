//
//  MainView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            ZStack {
                ButtonWindowView(isBack: false, home: true)
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
