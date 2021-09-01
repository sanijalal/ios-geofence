//
//  WelcomeViewPresenterTests.swift
//  GeofenceMeTests
//
//  Created by Abd Sani Abd Jalal on 01/09/2021.
//

import Foundation

import XCTest
import CoreLocation
@testable import GeofenceMe

class WelcomeViewPresenterTests: XCTestCase {
 
    func testStringReturnsCorrectlyForAuthorisationStatus() {
        let locationServiceMock = LocationServiceMock()
        let presenter = WelcomeViewPresenter(locationService: locationServiceMock)

        let testDictionary: [CLAuthorizationStatus: String] =
            [.authorizedAlways: "Authorised Always",
             .authorizedWhenInUse: "Authorised When In Use",
             .denied: "Denied",
             .notDetermined: "Not determined.",
             .restricted: "Restricted"
            ]
        
        for test in testDictionary {
            locationServiceMock.expectedStatus = test.key
            let text = presenter.text
            XCTAssertTrue(text == test.value, "Text is not as expected.")
        }
    }
    
    private func setupPresenterWithSpyWith(status: CLAuthorizationStatus) -> (WelcomeViewPresenter, AppCoordinatingSpy){
        let locationServiceMock = LocationServiceMock()
        let presenter = WelcomeViewPresenter(locationService: locationServiceMock)
        
        let spy = AppCoordinatingSpy()
        presenter.coordinator = spy
        
        locationServiceMock.expectedStatus = status
        return (presenter, spy)
    }
    
    func testCoordinatorPushGeofencePageWhenAuthorisedInUse() {
        let setup = setupPresenterWithSpyWith(status: .authorizedWhenInUse)
        let presenter = setup.0
        let spy = setup.1
        
        presenter.buttonPressed()
        
        XCTAssertTrue(spy.pushGeofenceViewCount == 1, "Coordinator is not pushing geofence view count")
    }
    
    func testCoordinatorPushGeofencePageWhenAuthorisedAlways() {
        let setup = setupPresenterWithSpyWith(status: .authorizedAlways)
        let presenter = setup.0
        let spy = setup.1
        
        presenter.buttonPressed()
        
        XCTAssertTrue(spy.pushGeofenceViewCount == 1, "Coordinator is not pushing geofence view count")
    }
    
    func testLocationServiceRequestPermissionWhenStatusNotDetermined() {
        let locationServiceMock = LocationServiceMock()
        locationServiceMock.expectedStatus = .notDetermined
        
        let presenter = WelcomeViewPresenter(locationService: locationServiceMock)
        presenter.buttonPressed()
        
        XCTAssertTrue(locationServiceMock.locationPermissionRequested == true, "Location Service not calling permission request when CLAuthorisationStatus is not determined.")
    }
}
