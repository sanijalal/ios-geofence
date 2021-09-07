//
//  GeofenceDetailsPresenterDelegate.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 07/09/2021.
//

import Foundation
import CoreLocation

protocol GeofenceDetailsPresenterDelegate: AnyObject {
    func locationUpdated(location: CLLocation)
    func updateZoomAtLocation(location: CLLocationCoordinate2D, zoom: Double)
    func updateFenceRegion(location: CLLocationCoordinate2D, radius: Double)
}
