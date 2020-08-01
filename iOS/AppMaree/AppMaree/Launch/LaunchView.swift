//
//  LaunchView.swift
//  AppMaree
//
//  Description : Il s'agit de la page affichée au lancement de l'application. Celle contenant les informations nécessaires à la première ouverture.
//
//  Si vous souhaitez modifier le texte, rendez-vous aux marqueurs sous forme de commentaire plus bas.
//
//  Created by unicaen on 26/06/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct LaunchView: View {
    
    @EnvironmentObject var settings : SettingsViewModel
    
    @State var autoSwitch: Bool = false
    @State var secondsLeft: Int = 3
    
    var body: some View {
        NavigationView {
            ZStack {
                ScrollView() {
                    VStack {
                        TitleView()
                            .padding(.bottom, 20)
                        // ---------------------------------- TEXTE 1 ----------------------------------
                        // Explication de la provenance des données ainsi que leur véracité.
                        // -----------------------------------------------------------------------------
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: UIScreen.main.bounds.height / 3.5)
                            .padding(.bottom, 20)
                        NavigationLink(destination: ConditionsView(secondsLeft: self.$secondsLeft)) {
                            Text("Lire les conditions d'utilisation")
                            .underline()
                            .foregroundColor(Color("Primaire 1"))
                            .padding(.bottom, 20)
                        }
                        
                        // Bouton principal permettant de fermer cette page.
                        if $settings.settings.agreement.wrappedValue {
                            NavigationLink(destination: MainView().environmentObject(settingsVM), isActive: $autoSwitch) {
                                EmptyView()
                            }
                            
                            StyledText("""
                            Conditions d'utilisation déjà acceptées !

                            Vous pouvez poursuivre en cliquant sur le bouton ci-dessous ou attendre \(self.$secondsLeft.wrappedValue) secondes.
                            """)
                            .style(.highlight(), ranges: { [$0.range(of: "Conditions d'utilisation déjà acceptées !")!]})
                            .style(.bold(), ranges: { [$0.range(of: "Conditions d'utilisation déjà acceptées !")!, $0.range(of: "cliquant sur le bouton ci-dessous")!,  $0.range(of: "\(self.$secondsLeft.wrappedValue) secondes")!]})
                                .padding([.leading, .bottom, .trailing], 20.0)
                                .multilineTextAlignment(.center)
                                .onAppear(perform: delay)
                            
                            Button(action: {
                                self.$autoSwitch.wrappedValue = true
                            }) {
                                ButtonMainView(colored: true)
                            }
                            .padding(.bottom, 20.0)
                        } else {
                            
                            Text("Vous devez accepter les conditions d'utilisation de l'application pour l'utiliser !")
                                .foregroundColor(Color.red)
                                .multilineTextAlignment(.center)
                                .padding(.top)
                            Spacer()
                        }
                    }.padding(.horizontal, 20)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .navigationBarHidden(true)
        .navigationBarTitle("")
        .edgesIgnoringSafeArea(.top)
    }
    
    private func delay() {
     
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.$secondsLeft.wrappedValue == 0 {
                self.$autoSwitch.wrappedValue = true
            } else if self.$secondsLeft.wrappedValue > 0 {
                self.$secondsLeft.wrappedValue -= 1
                self.delay()
            }
            
        }
        
    }
}
