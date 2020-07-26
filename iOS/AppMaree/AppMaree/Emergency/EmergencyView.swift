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
    @ObservedObject private var locationManager = LocationManager()
    
    var body: some View {
        
        let coordinate = self.locationManager.location != nil ? self.locationManager.location!.coordinate : CLLocationCoordinate2D()
        
        return ZStack {
            MapView()
            Text("\(coordinate.latitude), \(coordinate.longitude)")
                .foregroundColor(Color.white)
                .padding()
                .background(Color("Primaire 2"))
                .cornerRadius(30)
        }
        
        
    }
}

struct EmergencyView_Previews: PreviewProvider {
    static var previews: some View {
        EmergencyView()
    }
}
