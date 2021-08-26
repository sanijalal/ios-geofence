//
//  LocationServiceProvider.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation

class LocationServiceProvider: LocationServiceProviding {
    weak var delegate: LocationServiceDelegate?
    
    func startLocationDetection() {
        
    }
    
    func stopLocationDetection() {
        
    }

    func requestLocationPermission() {
        delegate?.authorisationStatusUpdated(.authorizedAlways)
    }
    
    func getCurrentAuthorisationState() -> CLAuthorizationStatus {
        return .authorizedAlways
    }
}
