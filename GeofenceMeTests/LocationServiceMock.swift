//
//  LocationServiceMock.swift
//  GeofenceMeTests
//
//  Created by user205283 on 8/28/21.
//

import Foundation
import CoreLocation
@testable import GeofenceMe

class LocationServiceMock: LocationServiceProviding {
    var isStartLocationDetectionCalled = false
    var isStopLocationDetectionCalled = false
    
    var expectedStatus: CLAuthorizationStatus = .authorizedAlways
    
    func requestLocationPermission() {
        
    }
    
    func getCurrentAuthorisationState() -> CLAuthorizationStatus {
        return expectedStatus
    }
    
    func startLocationDetection() {
        isStartLocationDetectionCalled = true
    }
    
    func stopLocationDetection() {
        isStopLocationDetectionCalled = true
    }
    
    func simulateLocationRetrieved(location: CLLocation) {
        delegate?.locationRetrieved(location: location)
    }
    
    var delegate: LocationServiceDelegate?
}
