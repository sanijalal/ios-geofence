//
//  GeofenceStorageMock.swift
//  GeofenceMeTests
//
//  Created by Sani on 25/08/2021.
//

import Foundation
@testable import GeofenceMe

class GeoFenceStorageMock: GeofenceStorageProviding {
    var info: GeofenceInfo?
    
    func saveGeofence(_ info: GeofenceInfo) {
        self.info = info
    }
    
    func getGeofence() -> GeofenceInfo? {
        info
    }
}

