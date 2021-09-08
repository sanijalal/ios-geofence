//
//  LocationServiceProviding.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation

protocol LocationServiceProviding {
    func requestLocationPermission()
    func getCurrentAuthorisationState() -> CLAuthorizationStatus
    func startLocationDetection()
    func stopLocationDetection()
    
    func startMonitoring(geofence: GeofenceInfo)
    func stopMonitoring(geofence: GeofenceInfo)
    func stopMonitorAllGeofences()
    
    var delegate: LocationServiceDelegate? { get set }
}
