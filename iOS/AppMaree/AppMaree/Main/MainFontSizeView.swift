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
    var color: CustomColor? = nil
    
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
                    Text(self.data)
                        .font(.system(size: 20))
                        .foregroundColor(contrastedTextColor(color: self.color))
                        .fixedSize(horizontal: true, vertical: true)
                }
            } else if self.$settingsVM.settings.fontSize.wrappedValue == 3 {
                if isDate {
                    Text(self.data)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                        .font(.system(size: 25))
                } else {
                    Text(self.data)
                        .font(.system(size: 25))
                        .foregroundColor(contrastedTextColor(color: self.color))
                        .fixedSize(horizontal: true, vertical: true)
                }
            } else {
                if isDate {
                    Text(self.data)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(.trailing)
                } else {
                    Text(self.data)
                        .foregroundColor(contrastedTextColor(color: self.color))
                        .fixedSize(horizontal: true, vertical: true)
                }
            }
        }
    }
    
    func contrastedTextColor(color: CustomColor?) -> Color {
        if color != nil && (color!.red+color!.green+color!.blue) <= 1.5 {
            return Color.white
        }
        
        return Color.black
    }
}
