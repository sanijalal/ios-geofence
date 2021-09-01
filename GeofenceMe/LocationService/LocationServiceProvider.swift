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
    
    func startMonitoring(geofence: GeofenceInfo) {
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: geofence.latitude, longitude: geofence.longitude),
                                      radius: CLLocationDistance(geofence.radius),
                                      identifier: "fence")
        region.notifyOnEntry = true
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoring(geofence: GeofenceInfo) {
        let region = CLCircularRegion(center: CLLocationCoordinate2D(latitude: geofence.latitude, longitude: geofence.longitude),
                                      radius: CLLocationDistance(geofence.radius),
                                      identifier: "fence")
        locationManager.stopMonitoring(for: region)
    }
}

extension LocationServiceProvider: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            delegate?.locationRetrieved(location: currentLocation)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error to get location")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        delegate?.authorisationStatusUpdatedWith(manager.authorizationStatus)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        delegate?.authorisationStatusUpdatedWith(status)
    }
}
