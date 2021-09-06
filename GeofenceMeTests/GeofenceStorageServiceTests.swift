//
//  GeofenceStorageServiceTests.swift
//  GeofenceMeTests
//
//  Created by Sani on 25/08/2021.
//

import XCTest
@testable import GeofenceMe

class GeofenceStorageServiceTests: XCTestCase {
    private var service: GeofenceStorageService!
    private var userDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        userDefaults = UserDefaults(suiteName: #file)
        userDefaults.removePersistentDomain(forName: #file)
        
        service = GeofenceStorageService(userDefaults: userDefaults)
    }
    
    private func defaultGeofenceInfo() -> GeofenceInfo {
        GeofenceInfo(latitude: 20,
                     longitude: 20,
                     radius: 4,
                     monitorOnExit: true,
                     monitorOnEntry: true,
                     geofenceName: "gesundheit")
    }
    
    func testSavesGeofenceShouldKeepInUserDefaults() {
        service.saveGeofence(defaultGeofenceInfo())
        let data = userDefaults.data(forKey: "geofence")
        XCTAssertTrue(data != nil)
    }
    
    func testWhenNoGeofenceInfoIsStoredShouldNotRetrieveGeofenceInfo() {
        let info = service.getGeofence()
        XCTAssertTrue(info == nil, "No geofence info should be retrieved but is retrieved.")
    }
    
    func testDeleteRemovesGeofenceInfo() {
        service.saveGeofence(defaultGeofenceInfo())
        let info = service.getGeofence()
        XCTAssertTrue(info != nil, "Geofence info should be retrieved but is not retrieved.")
        service.deleteGeofence()
        let infoAfterDelete = service.getGeofence()
        XCTAssertTrue(infoAfterDelete == nil, "No geofence info should be retrieved but is retrieved.")
    }
}
