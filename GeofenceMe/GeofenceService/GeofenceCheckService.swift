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
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: geofence.latitude, longitude: geofence.longitude),
                                      radius: CLLocationDistance(geofence.radius), identifier: "sani")
        return region.contains(CLLocationCoordinate2D(latitude: latitude, longitude: longitude))
    }
}
