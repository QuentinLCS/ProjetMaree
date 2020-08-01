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
        
        return NavigationView { 
            ZStack {
                ScrollView {
                        TitleView(title: "APPEL AU SECOURS", titleColor: Color.red)

                        EmergencyMessageView()
                            .padding(.bottom, 30)
                    
                        ZStack {
                            MapView()
                                .padding(.top, 25)
                            VStack(spacing: 0) {
                                Text("lat: \(coordinateConverter(coord: coordinate.latitude, isLat: true)), long: \(coordinateConverter(coord: coordinate.longitude, isLat: false))")
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
            .navigationViewStyle(StackNavigationViewStyle())
            .navigationBarHidden(true)
            .navigationBarTitle("")
            .edgesIgnoringSafeArea(.vertical)
    }
    
    func coordinateConverter(coord: Double, isLat: Bool) -> String {
        var result = ""
        
        if isLat {
            if coord < 0 {
                result += "\(abs(coord))S"
            } else {
                result += "\(abs(coord))N"
            }
        } else {
            if coord < 0 {
                result += "\(abs(coord))W"
            } else {
                result += "\(abs(coord))E"
            }
        }
        
        return result
    }
}
