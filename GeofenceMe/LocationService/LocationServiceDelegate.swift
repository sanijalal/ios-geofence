//
//  LocationServiceDelegateProtocol.swift
//  GeofenceMe
//
//  Created by Sani on 24/08/2021.
//

import Foundation
import CoreLocation

protocol LocationServiceDelegate {
    func authorisationStatusUpdatedWith(_ status: CLAuthorizationStatus)
    func locationRetrieved(location: CLLocation)
}
