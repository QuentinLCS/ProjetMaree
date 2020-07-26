//
//  MainFontSizeView.swift
//  AppMaree
//
//  Created by unicaen on 26/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI

struct MainFontSizeView: View {
    
    @EnvironmentObject var settingsVM : SettingsViewModel
    var data: String
    var isDate: Bool = false
    
    var body: some View {
        ZStack {
        
            if self.$settingsVM.settings.fontSize.wrappedValue == 2 {
                if isDate {
                    Text(self.data)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.system(size: 20))
                } else {
                    Text(self.data).font(.system(size: 20))
                }
            } else if self.$settingsVM.settings.fontSize.wrappedValue == 3 {
                if isDate {
                    Text(self.data)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.system(size: 25))
                } else {
                    Text(self.data).font(.system(size: 25))
                }
            } else {
                if isDate {
                    Text(self.data)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                } else {
                    Text(self.data)
                }
            }
        }
    }
}
