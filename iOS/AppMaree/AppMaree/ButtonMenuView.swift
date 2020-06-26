//
//  ButtonMenuView.swift
//  AppMaree
//
//  Created by unicaen on 25/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct ButtonMenuView: View {
    let label:String
    let image:String
    
    var body: some View {
        VStack {
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Spacer()
            Text(label)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .multilineTextAlignment(.center)
        }
        
        .frame(width: 100.0, height: 100.00)
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonMenuView(label: "label", image: "image")
    }
}
