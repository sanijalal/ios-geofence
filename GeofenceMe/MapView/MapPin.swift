//
//  MapPin.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation
import MapKit

class MapPin: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        super.init()
    }
}
