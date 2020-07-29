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

struct ButtonFishView: View {
    let backgroundColor: FishButtonColorType
    let name: String
    let image: String
    let size: Double?
    
    init(backgroundColor: FishButtonColorType, name: String, image: String, size: Double? = nil) {
        self.backgroundColor = backgroundColor
        self.name = name
        self.image = image
        self.size = size
    }
    
    var body: some View {
       
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundColor(Color(backgroundColor.rawValue))
                VStack {
                    Group {
                        if (image != "") {
                            Image(image)
                            .resizable()
                            .scaledToFit()
                        }
                        else {
                            Image(systemName: "ellipsis")
                        }
                    }
                    
                    Text(name)
                        .font(.system(size: 15))
                        .foregroundColor(self.backgroundColor == .secondaryColor ? Color.white : Color.black)
    
                    if (size != nil) {
                        Text("\(doShortDouble(value: size!, decimals: 1)) cm")
                            .font(.system(size: 13))
                            .foregroundColor(self.backgroundColor == .secondaryColor ? Color.white : Color.black)
                    }
                }
            }
            .frame(width: 180.0, height: 120.0)
    }
}

func makeUIView(of name: String, from bundleName: String) -> UIImage {
    let MainBundleURL = Bundle.main.bundleURL
    let bundle = Bundle( url: MainBundleURL.appendingPathComponent("\(bundleName).bundle"))
    let ImageData = UIImage(named: name, in: bundle, with: nil) ?? UIImage(systemName: "ellipsis")!
    return ImageData
}
