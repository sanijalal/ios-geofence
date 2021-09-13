//
//  GeofenceViewModel.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

struct GeofenceViewModel {
    var geofenceInfo: GeofenceInfo?
    var isInGeofence: Bool = false
    
    var latitude: Double = 0
    var longitude: Double = 0
    
    var currentSSIDName: String?
}
