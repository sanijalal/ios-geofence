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
    private var notificationService: NotificationService
    
    init(locationManager: CLLocationManager, notificationService: NotificationService = NotificationService()) {
        self.locationManager = locationManager
        self.notificationService = notificationService
        super.init()
    }
    
    func start() {
        clearNotifications()
        locationManager.delegate = self
    }
    
    func stop() {
        locationManager.delegate = nil
    }
    
    func clearNotifications() {
        notificationService.clearNotifications()
    }
}

extension GeofenceMonitor: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        notificationService.sendLocalNotification(text: "Entered Region!")
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        notificationService.sendLocalNotification(text: "Exit Region!")
    }
}
