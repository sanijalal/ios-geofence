//
//  GeofenceDetailsViewModel.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import Foundation

struct GeofenceDetailsViewModel {
    var name: String = ""
    var associatedSSID: String? = nil
    var radius: Double = 0
    var latitude: Double = -8.57690235583438
    var longitude: Double = 115.08637086136436
    var notifyOnEntry: Bool = false
    var notifyOnExit: Bool = false
    var isUsingCurrentLocation = true
    
    var shouldHighlightName: Bool = false
    var shouldHighlightOnEntry: Bool = false
    var shouldHighlightOnExit: Bool = false
}
