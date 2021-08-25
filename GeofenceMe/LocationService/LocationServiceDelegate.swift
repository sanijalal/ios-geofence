//
//  LocationServiceDelegateProtocol.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func authorisationStatusUpdated(_ with: CLAuthorizationStatus)
}
