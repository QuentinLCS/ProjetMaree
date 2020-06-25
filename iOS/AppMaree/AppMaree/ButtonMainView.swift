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
    
    init(colored: Bool = true) {
        self.colored = colored
    }
    
    var body: some View {
        
        Image(colored ? "back" : "colored_back")
        .resizable()
        .aspectRatio(1, contentMode: .fit)
        .padding(25)
        .background(
             LinearGradient(gradient: Gradient(colors: [colored ? Color("Primaire 1") : Color.white, colored ? Color("Primaire 1") : Color.white]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
        )
        .cornerRadius(100)
        .frame(width: 100, height: 100)
    }
}

struct ButtonMainView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMainView()
    }
}
