//
//  GeofenceMonitor.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 01/09/2021.
//

import Foundation
import CoreLocation

class GeofenceMonitor: NSObject {
    private var locationManager: CLLocationManager
    
    init(locationManager: CLLocationManager) {
        self.locationManager = locationManager
        super.init()
    }
    
    func start() {
        locationManager.delegate = self
    }
    
    func stop() {
        locationManager.delegate = nil
    }
}

extension GeofenceMonitor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
    }
}
