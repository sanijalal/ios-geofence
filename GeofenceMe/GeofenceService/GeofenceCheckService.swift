//
//  GeofenceCheckService.swift
//  GeofenceMe
//
//  Created by Sani on 26/08/2021.
//

import Foundation
import CoreLocation

class GeofenceCheckService {
    class func isGeofenceInLocation(geofence: GeofenceInfo, latitude: Double, longitude: Double) -> Bool {
        let geofenceLocation = CLLocation(latitude: geofence.latitude, longitude: geofence.longitude)
        let currentLocation = CLLocation(latitude: latitude, longitude: longitude)
        let distance = geofenceLocation.distance(from: currentLocation)
        
        return distance <= Double(geofence.radius)
    }
}
