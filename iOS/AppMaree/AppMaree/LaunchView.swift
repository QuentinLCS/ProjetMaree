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
            ZStack {
                VStack() {
                    TitleView()
                    HStack(spacing: 10.0) {
                            Spacer()
                        StyledText("""
    Les données affichées sur cette application sont issues du GUIDE IMPRIMÉ et distribué gratuitement. Elles ne sont qu'indicatives.

     Certaines ont été fournies par le SHOM, d'autres sont calculées. Les horaires sont en HEURE LÉGALE et ne prennent pas en compte les variations liées à la météorologie ou à des effets locaux particuliers. En aucun cas, elles ne peuvent être utilisées pour la navigation maritime.
    """)
                            .style(.highlight(), ranges: { [$0.range(of: "Elles ne sont qu'indicatives.")!] })
                            .style(.bold(), ranges: { [$0.range(of: "GUIDE IMPRIMÉ")!, $0.range(of: "HEURE LÉGALE")!, $0.range(of: "Elles ne sont qu'indicatives.")! ]})
                            .font(.system(size: 20))
                        .background(Image("logo").opacity(0.3))
                            
                            Spacer()
                    }
                    .padding(.top)
                    ZStack {
                        DiagonalBackgroundView(a: .primaryColor)

                        VStack {
                            HStack {
                                Spacer()
                                Text("L'association et les auteurs de cette application ne peuvent être tenus responsables d'incidents ou d'accidents engendrés par la lecture des informations de cette application.")
                                .font(.system(size: 18))
                                Spacer()
                            }
                            .padding(.top, 40.0)
                            
                            HStack{
                                Text("En cliquant sur ")
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.system(size: 20))
                                
                                Image(systemName: "xmark.circle.fill")
                                    .font(.title)
                                
                                Text(" vous affirmez avoir")
                                .bold()
                                .multilineTextAlignment(.center)
                                .font(.system(size: 18))
                            }
                            .padding(.top)
                            
                            Text("pris connaissance de cet avertissement.")
                            .bold()
                            .multilineTextAlignment(.center)
                            .font(.system(size: 18))
                            
                            Text("Acceptation SHOM 2019 - 2021")
                                .fontWeight(.semibold)
                                .foregroundColor(Color.white)
                                .padding(.top, 30.0)
                            
                            Spacer()
                        }
                    }
                    .padding(.top, 25.0)
                }
                ButtonWindowView(isBack: false)
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
