//
//  WeatherDetailsView.swift
//  AppMaree
//
//  Created by unicaen on 30/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct WeatherDetailsView: View {
    
    var listData: [ListData] = []
    var value: Int = 0
    var height: CGFloat = 0
    var width: CGFloat = UIScreen.main.bounds.width / 2
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(listData) { data in
                    CardView(data: data)
                        .frame(width: self.width, height: self.value == 0 ? 0 : self.height * 0.60)
                        .animation(.easeInOut(duration: 0.5))
                        .modifier(CardViewModifier())
                }
            }
        }
        .padding(.bottom, 60)
        .frame(height: self.value == 0 ? 0 : self.height * 0.65).animation(.easeInOut(duration: 0.5))
    }
}
