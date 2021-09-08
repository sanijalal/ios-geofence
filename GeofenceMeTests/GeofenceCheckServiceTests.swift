//
//  GeofenceCheckServiceTests.swift
//  GeofenceMeTests
//
//  Created by user205283 on 8/28/21.
//

import XCTest
@testable import GeofenceMe

class GeofenceCheckServiceTests: XCTestCase {

    private func createGeofenceInfo(latitude: Double = 24, longitude: Double = 26, radius: Double = 1000, ssid: String? = nil) -> GeofenceInfo {
        return GeofenceInfo(latitude: latitude,
                            longitude: longitude,
                            radius: radius,
                            monitorOnExit: true,
                            monitorOnEntry: true,
                            geofenceName: "sani",
                            ssid: ssid)
    }
    
    func testReturnTrueWhenLocationIsGeofenceCenter() throws {
        let geofence = createGeofenceInfo()
        let latitude: Double = 24
        let longitude: Double = 26
        let isInside = GeofenceCheckService.isGeofenceInLocation(geofence: geofence,
                                                  latitude: latitude,
                                                  longitude: longitude)
        XCTAssertTrue(isInside == true, "Expected true for coordinates but service returns false.")
    }
    
    func testReturnTrueWhenLocationIsInsideGeofenceRadius() throws {
        let geofence = createGeofenceInfo()
        let latitude: Double = 24.0001
        let longitude: Double = 26.0001
        let isInside = GeofenceCheckService.isGeofenceInLocation(geofence: geofence,
                                                  latitude: latitude,
                                                  longitude: longitude)
        XCTAssertTrue(isInside == true, "Expected true for coordinates but service returns false.")
    }
    
    func testReturnFalseWhenLocationIsOutsideGeofenceRadius() throws {
        let geofence = createGeofenceInfo()
        let latitude: Double = 44
        let longitude: Double = 65
        let isInside = GeofenceCheckService.isGeofenceInLocation(geofence: geofence,
                                                  latitude: latitude,
                                                  longitude: longitude)
        XCTAssertTrue(isInside == false, "Expected false for coordinates but service returns true.")
    }

}
