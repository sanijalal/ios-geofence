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
        let location = CLLocation(latitude: geofence.latitude, longitude: geofence.longitude)
        let distance = location.distance(from: CLLocation(latitude: latitude, longitude: longitude))
        
        return distance <= Double(geofence.radius)
    }
}
