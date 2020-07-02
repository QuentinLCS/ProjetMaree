//
//  ButtonFishDetailsView.swift
//  AppMaree
//
//  Created by unicaen on 28/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

enum FishButtonColorType: String {
    case primaryColor = "Primaire 1"
    case secondaryColor = "Primaire 2"
    case white = "White"
}

struct ButtonFishDetailsView: View {
    let backgroundColor: FishButtonColorType
    let name: String
    let image: String
    let size: Int
    let bundleName: String
    
    var body: some View {
       
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(backgroundColor.rawValue))
                VStack {
                    Image(uiImage: makeUIView(of: image, from: bundleName))
                    .resizable()
                    .scaledToFit()
                Text(name)
                    .font(.system(size: 15))
                Text("\(size) cm")
                    .font(.system(size: 10))
                }
            }
            .frame(width: 150.0, height: 100.0)
    }
}

func makeUIView(of name: String, from bundleName: String) -> UIImage {
    let MainBundleURL = Bundle.main.bundleURL
    let bundle = Bundle( url: MainBundleURL.appendingPathComponent("\(bundleName).bundle"))
    return UIImage(named: name, in: bundle, with: nil)!
}


struct ButtonFishDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonFishDetailsView(backgroundColor: .white, name: "BAR", image: "Bar_25.png", size: 42, bundleName: "Poisson")
    }
}
