//
//  TitleView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct TitleView: View {
    
    private let title:String
    private let titleColor:Color
    private let subTitle:String?
    private let subTitleColor:Color?
    
    init(title:String = "PORT-DIELETTE", titleColor:Color = Color("Primaire 1")) {
        self.title = title
        self.titleColor = titleColor
        self.subTitle = nil
        self.subTitleColor = nil
    }
    
    init(title:String, titleColor:Color, subTitle:String, subTitleColor:Color) {
        self.title = title
        self.titleColor = titleColor
        self.subTitle = subTitle
        self.subTitleColor = subTitleColor
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(titleColor)
                if subTitle != nil {
                    Text(String(subTitle!))
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(subTitleColor)
                }
            }
        }.frame(height: 50.0)
        
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
