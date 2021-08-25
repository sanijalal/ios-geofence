//
//  AddGeofenceViewModel.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation
import CoreLocation

struct AddGeofenceViewModel {
    var latitude: Double = 0
    var longitude: Double = 0
    var currentFenceRange: CLLocationDistance = 50
}
