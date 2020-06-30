//
//  LaunchView.swift
//  AppMaree
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        NavigationView {
            VStack {
                TitleView()
                HStack(spacing: 20.0) {
                        Spacer()
                    StyledText("""
Les données affichées sur cette application sont issues du GUIDE IMPRIMÉ et distribué gratuitement. Elles ne sont qu'indicatives.

 Certaines ont été fournies par le SHOM, d'autres sont calculées. Les horaires sont en HEURE LEGALE et ne prennent pas en compte les variations liées à la météorologie ou à des effets locaux particuliers. En aucun cas, elles ne peuvent être utilisées pour la navigation maritime. ETC
""")
                        .style(.highlight(), ranges: { [$0.range(of: "Elles ne sont qu'indicatives.")!] })
                        .style(.bold(), ranges: { [$0.range(of: "GUIDE IMPRIMÉ")!, $0.range(of: "HEURE LEGALE")!, $0.range(of: "Elles ne sont qu'indicatives.")! ]})
                        Spacer()
                }
                HomeButtonView(isBack: false)
            }
        }
        .navigationBarHidden(true)
        .navigationBarTitle("titre")
        .edgesIgnoringSafeArea(.all)
    }
}

extension TextStyle {
    static func highlight() -> TextStyle { .foregroundColor(Color("Primaire 1")) }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
