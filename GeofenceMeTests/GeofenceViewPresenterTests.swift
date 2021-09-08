//
//  GeofenceViewPresenterTests.swift
//  GeofenceMeTests
//
//  Created by user205283 on 8/28/21.
//

import XCTest
import CoreLocation
@testable import GeofenceMe

class GeofenceViewPresenterTests: XCTestCase {

    private let defaultLongitude: Double = 24
    private let defaultLatitude: Double = 24
    private let defaultSSIDName = "cekodok"
    private let defaultRadius = 10.0

    private func defaultGeofenceInfo() -> GeofenceInfo {
        return GeofenceInfo(latitude: defaultLatitude,
                            longitude: defaultLongitude,
                            radius: defaultRadius,
                            monitorOnExit: true,
                            monitorOnEntry: true,
                            geofenceName: "sani",
                            ssid: nil)
    }
    
    private func defaultViewModel() -> GeofenceViewModel {
        return GeofenceViewModel(geofenceInfo: defaultGeofenceInfo(),
                                             isInGeofence: true,
                                     latitude: defaultLatitude,
                                     longitude: defaultLongitude, currentSSIDName: defaultSSIDName)
    }
    
    private func defaultPresenterWithNoGeofence() -> GeofenceViewPresenter {
        let model = GeofenceViewModel(geofenceInfo: defaultGeofenceInfo(),
                                      isInGeofence: true,
                              latitude: defaultLatitude,
                              longitude: defaultLongitude, currentSSIDName: defaultSSIDName)
        let storageProviding = GeoFenceStorageMock()
        return GeofenceViewPresenter(viewModel: model,
                                     geofenceService: storageProviding, wifiService: WifiDetectorService(), locationService: LocationServiceMock())
    }
    
    private func defaultPresenterWithGeofence() -> GeofenceViewPresenter {
        let model = GeofenceViewModel(geofenceInfo: defaultGeofenceInfo(),
                                      isInGeofence: true,
                              latitude: defaultLatitude,
                              longitude: defaultLongitude, currentSSIDName: defaultSSIDName)
        let storageProviding = GeoFenceStorageMock()
        storageProviding.info = defaultGeofenceInfo()
        return GeofenceViewPresenter(viewModel: model,
                                     geofenceService: storageProviding, wifiService: WifiDetectorService(), locationService: LocationServiceMock())
    }
    
    func testGeofenceReturnNilWhenGeofenceStorageReturnsNil() throws {
        let presenter = defaultPresenterWithNoGeofence()
        presenter.getData()
        let geofence = presenter.geofenceInfo
        
        XCTAssertTrue(geofence == nil, "Geofence is not nil even when storage has nil Geofence")
    }
    
    func testGeofenceIsReturnedWhenGeofenceStorageHasGeofenceInfo() {
        let latitudeToTest: Double = 12
        let longitudeToTest: Double = 14
        let radiusToTest: Double = 243.0
        let ssidToTest = "Wax"
        let name = "Namaku"
        let onExit = true
        let onEntry = true
        
        let geofenceStorageService = GeoFenceStorageMock()
        geofenceStorageService.info = GeofenceInfo(latitude: latitudeToTest,
                                                   longitude: longitudeToTest,
                                                   radius: radiusToTest,
                                                   monitorOnExit: onExit,
                                                   monitorOnEntry: onEntry,
                                                   geofenceName: name,
                                                   ssid: ssidToTest)
        
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: geofenceStorageService, wifiService: WifiDetectorService(), locationService: LocationServiceMock())
        
        presenter.getData()
        let geofenceInfo = presenter.geofenceInfo
        
        XCTAssertTrue(geofenceInfo?.latitude == latitudeToTest, "Latitude in presenter GeofenceInfo is not of expected value.")
        XCTAssertTrue(geofenceInfo?.longitude == longitudeToTest, "Longitude in presenter GeofenceInfo is not of expected value.")
        XCTAssertTrue(geofenceInfo?.radius == radiusToTest, "Radius in presenter GeofenceInfo is not of expected value.")
        XCTAssertTrue(geofenceInfo?.ssid == ssidToTest, "SSID in presenter GeofenceInfo is not of expected value.")
    }
    
    func testCoordinateIsSameAsInitialisedWhenLocationIsNotRetrieved () {
        let presenter = defaultPresenterWithNoGeofence()
        XCTAssertTrue(presenter.latitude == defaultLatitude, "Latitude in presenter is not as per initialised")
        XCTAssertTrue(presenter.longitude == defaultLongitude, "Longitude in presenter is not as per initialised")
    }
    
    func testIsGeofenceAvailableReturnsFalseWhenNoGeofenceInfoIsInStorage () {
        
        let geofenceStorageService = GeoFenceStorageMock()
        geofenceStorageService.info = nil
        
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: geofenceStorageService, wifiService: WifiDetectorService(), locationService: LocationServiceMock())
        presenter.getData()
        
        let isGeofenceAvailable = presenter.isGeofenceAvailable
        XCTAssertTrue(isGeofenceAvailable == false, "IsGeofenceAvailable returns true even when storage has no geofence")
    }
    
    func testIsGeofenceAvailableReturnsTrueWhenGeofenceInfoIsInStorage () {
        
        let geofenceStorageService = GeoFenceStorageMock()
        geofenceStorageService.info = defaultGeofenceInfo()
        
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: geofenceStorageService, wifiService: WifiDetectorService(), locationService: LocationServiceMock())
        
        let isGeofenceAvailable = presenter.isGeofenceAvailable
        XCTAssertTrue(isGeofenceAvailable == true, "IsGeofenceAvailable returns false even when storage has geofence")
    }
    
    func testDisplayValuesAreCorrectWhenGeofenceInfoIsInStorage () {
        let presenter = defaultPresenterWithGeofence()
        XCTAssertTrue(presenter.geofenceLabelString == "Geofence configured", "Geofence configured is not shown.")
    }
    
    func testDisplayValuesAreCorrectWhenGeofenceInfoIsNotInStorage () {
        let presenter = defaultPresenterWithNoGeofence()
        presenter.getData()
        XCTAssertTrue(presenter.geofenceLabelString == "No geofence configured.", "No geofence configured is not shown.")
    }
    
    func testLocationServiceIsCalledWhenLocationDetectionIsCalled () {
        let locationService = LocationServiceMock()
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: GeoFenceStorageMock(), wifiService: WifiDetectorService(), locationService: locationService)
        
        presenter.startLocationDetection()
        
        XCTAssertTrue(locationService.isStartLocationDetectionCalled, "Start Locaton is not called when Presenter requests start location detection")
    }
    
    func testLocationServiceIsStoppedWhenLocationDetectionIsStopped () {
        let locationService = LocationServiceMock()
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: GeoFenceStorageMock(), wifiService: WifiDetectorService(), locationService: locationService)
        
        presenter.stopLocationDetection()
        
        XCTAssertTrue(locationService.isStopLocationDetectionCalled, "Stop Locaton is not called when Presenter requests stop location detection")
    }
    
    func testLocationIsInsideGeofenceWhenLocationServiceReturnsLocationOfGeofence () {
        let geofenceInfo = defaultGeofenceInfo()
        let simulatedLocation = CLLocation(latitude: geofenceInfo.latitude, longitude: geofenceInfo.longitude)
        let presenter = setupPresenterWithLocationInGeofence(location: simulatedLocation, geofenceInfo: geofenceInfo)
        
        XCTAssertTrue(presenter.latitude == simulatedLocation.coordinate.latitude, "Latitude in presenter is not the same as returned by location service.")
        XCTAssertTrue(presenter.longitude == simulatedLocation.coordinate.longitude, "Longitude in presenter is not the same as returned by location service.")
        XCTAssertTrue(presenter.insideOutsideLabelString == "You are inside the geofence.", "Presenter not displaying inside geofence string")
        
    }
    
    func testLocationIsOutsideGeofenceWhenLocationServiceReturnsLocationOutsideGeofence () {
        
        let expectedGeofenceInfo = defaultGeofenceInfo()
        
        let geofenceService = GeoFenceStorageMock()
        geofenceService.info = expectedGeofenceInfo
        
        let locationService = LocationServiceMock()
        
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: geofenceService, wifiService: WifiDetectorService(), locationService: locationService)
        
        // Dont go crazy with the latitude longitude values
        // https://stackoverflow.com/questions/33346082/cllocation-distancefromlocation-returns-zero-on-ios-9-is-it-a-bug
        // Latitude should be within (90, -90)
        let simulatedLocation = CLLocation(latitude: 40, longitude: 40)
        
        locationService.simulateLocationRetrieved(location: simulatedLocation)
        
        XCTAssertTrue(presenter.latitude == simulatedLocation.coordinate.latitude, "Latitude in presenter is not the same as returned by location service.")
        XCTAssertTrue(presenter.longitude == simulatedLocation.coordinate.longitude, "Longitude in presenter is not the same as returned by location service.")
        XCTAssertTrue(presenter.insideOutsideLabelString == "You are outside the geofence.", "Presenter not displaying outside geofence string")
        
    }
    
    func testGeofenceConfiguredColorNamedReturnWhenNoGeofenceIsConfigured() {
        let presenter = defaultPresenterWithNoGeofence()
        presenter.getData()
        let colorName = presenter.geofenceColorName
        XCTAssertTrue(colorName == "NoGeofenceColor", "Name of color returned is not correct")
    }
    
    func testGeofenceConfiguredColorNamedReturnWhenGeofenceIsConfigured() {
        let presenter = defaultPresenterWithGeofence()
        presenter.getData()
        let colorName = presenter.geofenceColorName
        XCTAssertTrue(colorName == "HasGeofenceColor", "Name of color returned is not correct.")
    }
    
    private func setupPresenterWithLocationInGeofence(location: CLLocation, geofenceInfo: GeofenceInfo) -> GeofenceViewPresenter {
        let expectedGeofenceInfo = geofenceInfo
        
        let geofenceService = GeoFenceStorageMock()
        geofenceService.info = expectedGeofenceInfo
        
        let locationService = LocationServiceMock()
        
        let presenter = GeofenceViewPresenter(viewModel: defaultViewModel(), geofenceService: geofenceService, wifiService: WifiDetectorService(), locationService: locationService)
        presenter.getData()

        locationService.simulateLocationRetrieved(location: location)
        return presenter
    }
}
