//
//  EmergencyView.swift
//  AppMaree
//
//  Created by unicaen on 26/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import SwiftUI
import MapKit

struct EmergencyView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        return ZStack {
           VStack {
                TitleView(title: "SIGNALER UN PROBLÈME", titleColor: Color.red)

                EmergencyMessageView()
            
                ZStack {
                    MapView()
                        .padding(.top, 25)
                    VStack(spacing: 0) {
                        Text("lat: \(coordinate.latitude), long: \(coordinate.longitude)")
                            .fontWeight(.semibold)
                            .foregroundColor(Color.white)
                            .padding()
                            .background(Color("Primaire 2"))
                            .cornerRadius(30)
                            .shadow(radius: 10)
                        Spacer()
                    }
                }.frame(height: 350)
            }
            ButtonWindowView(isBack: true, presentation: presentationMode)
        }
        
        
    }
}
