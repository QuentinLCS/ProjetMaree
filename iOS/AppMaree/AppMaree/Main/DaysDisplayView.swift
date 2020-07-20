//
//  DaysDisplayView.swift
//  AppMaree
//
//  Created by unicaen on 19/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct DaysDisplayView: View {
    var body: some View {
        ScrollView {
            VStack {
                ForEach(0..<self.days.count) { number in
                    
                    MainDataRow(day: self.days[number])
                        .background(Color.white.opacity(self.opacities[number % 2]))
                }
            }
            TitleView(title: "FIN", titleColor: Color.white, backgroundColor: .clear)
        }
    }
}

struct DaysDisplayView_Previews: PreviewProvider {
    static var previews: some View {
        DaysDisplayView()
    }
}
