//
//  GeofenceDetailsPresenterDelegateTestSpy.swift
//  GeofenceMeTests
//
//  Created by Abd Sani Abd Jalal on 08/09/2021.
//

import Foundation
import CoreLocation
@testable import GeofenceMe

class GeofenceDetailsPresenterDelegateTestSpy: GeofenceDetailsPresenterDelegate {
    var locationUpdatedCalled = 0
    var updateZoomAtLocationCalled = 0
    var updateFenceRegionCalled = 0
    var dataNotValidCalled = 0
    var refreshHighlightsCalled = 0
    
    func locationUpdated(location: CLLocation) {
        locationUpdatedCalled += 1
    }
    
    func updateZoomAtLocation(location: CLLocationCoordinate2D, zoom: Double) {
        updateZoomAtLocationCalled += 1
    }
    
    func updateFenceRegion(location: CLLocationCoordinate2D, radius: Double) {
        updateFenceRegionCalled += 1
    }
    
    func dataNotValid(status: GeofenceDetailValidationStatus) {
        dataNotValidCalled += 1
    }
    
    func refreshHighlights() {
        refreshHighlightsCalled += 1
    }
    
    
}
