//
//  Coordinator.swift
//  AppMaree
//
//  Created by unicaen on 26/07/2020.
//  Copyright © 2020 unicaen. All rights reserved.
//

import Foundation
import MapKit

final class Coordinator: NSObject, MKMapViewDelegate {
    
    var control: MapView
    
    init(_ control: MapView) {
        self.control = control
    }
    
}
