//
//  ButtonMainView.swift
//  AppMaree
//
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ButtonMainView: View {
    
    private let colored:Bool
    private let home:Bool
    
    init(home: Bool = false, colored: Bool) {
        self.home = home
        self.colored = colored

    }
    
    var body: some View {
        VStack {
            
            ZStack {
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color.white.opacity(0),Color.white]), startPoint: .top, endPoint: .bottom))
                VStack {

                    Image(home ? "home" : colored ? "back" : "colored_back")
                        .renderingMode(.original)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                        .padding(25.0)
                    .background(
                         LinearGradient(gradient: Gradient(colors: [colored ? Color("Primaire 1") : Color.white, colored ? Color("Primaire 2") : Color.white]), startPoint: .top, endPoint: .bottom)
                    )
                    
                    .clipShape(Circle())
                        .frame(width: 100, height: 100, alignment: .bottom)
                    .padding(.bottom, 50.0)
                }
            }
            .frame(height: 250.0)
        }
    }
    
    struct MainView_Previews: PreviewProvider {
        static var previews: some View {
            ButtonMainView(colored: true)
        }
    }
}
