//
//  LocationServiceProvider.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation

class LocationServiceProvider: NSObject, LocationServiceProviding {
    var delegate: LocationServiceDelegate?
    private var locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManager = locationManager
        super.init()
        self.locationManager.delegate = self
    }
    
    deinit {
        self.locationManager.delegate = nil
    }
    
    func startLocationDetection() {
        locationManager.startUpdatingLocation()
    }
    
    func stopLocationDetection() {
        locationManager.stopUpdatingLocation()
    }

    func requestLocationPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    
    func getCurrentAuthorisationState() -> CLAuthorizationStatus {
        return locationManager.authorizationStatus
    }
}

extension LocationServiceProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("Did update location")
        if let currentLocation = locations.last {
            delegate?.locationRetrieved(location: currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location")
    }
}
