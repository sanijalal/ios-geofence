//
//  AddGeofencePresenterViewTests.swift
//  GeofenceMeTests
//
//  Created by Sani on 25/08/2021.
//

import XCTest
@testable import GeofenceMe

class AddGeofencePresenterViewTests: XCTestCase {
    
    func testSegmentValueChangeChangesRadius() {
        let presenter = AddGeofenceViewPresenter()
        
        let cases = [(0, 50), (1, 100), (2,150)]
        
        cases.forEach { testCase in
            presenter.segmentSelected(index: testCase.0)
            XCTAssertTrue(Int(presenter.currentFenceRange) == testCase.1, "Current Segment: \(testCase.0) range is not as expected: \(testCase.1): Actual: \(presenter.currentFenceRange)")
        }
    }
    
    func testSegmentSelectionShouldNotSaveGeofenceInfoWhenSaveFunctionIsNotCalled() {
        let storageMock = GeoFenceStorageMock()
        let presenter = AddGeofenceViewPresenter(geofenceService: storageMock)
        presenter.segmentSelected(index: 1)
        
        let geofenceInfo = storageMock.getGeofence()
        XCTAssert(geofenceInfo == nil, "Geofence Info is expected to be nil. It is not nil")
    }
    
    func testSaveGeofenceInfoSavesGeofenceInfo() {
        let storageMock = GeoFenceStorageMock()
        let viewModel = AddGeofenceViewModel(latitude: 21.0, longitude: 24.0, currentFenceRange: 20)
        
        let presenter = AddGeofenceViewPresenter(geofenceService: storageMock, viewModel: viewModel)
        presenter.saveGeofence()
        
        let geofenceInfo = storageMock.getGeofence()
        XCTAssert(geofenceInfo != nil, "Geofence Info is nil. Expected to not be nil.")
    }
    
    
}
