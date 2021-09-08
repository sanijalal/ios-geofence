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
        let coordinate = CLLocationCoordinate2D(latitude: geofence.latitude, longitude: geofence.longitude)
        let region = CLCircularRegion(center: coordinate,
                                      radius: CLLocationDistance(geofence.radius),
                                      identifier: geofence.geofenceName)
        region.notifyOnEntry = geofence.monitorOnEntry
        region.notifyOnExit = geofence.monitorOnExit
        locationManager.startMonitoring(for: region)
    }
    
    func stopMonitoring(geofence: GeofenceInfo) {
        let monitoredRegions = locationManager.monitoredRegions
        let regionForGeofence = monitoredRegions.filter { region in
            region.identifier == geofence.geofenceName
        }
        
        for region in regionForGeofence {
            locationManager.stopMonitoring(for: region)
        }
    }
    
    func stopMonitorAllGeofences() {
        let monitoredRegions = locationManager.monitoredRegions
        for region in monitoredRegions {
            locationManager.stopMonitoring(for: region)
        }
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
