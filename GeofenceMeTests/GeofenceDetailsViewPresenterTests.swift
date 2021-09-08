//
//  GeofenceDetailsViewPresenterTests.swift
//  GeofenceMeTests
//
//  Created by Abd Sani Abd Jalal on 08/09/2021.
//

import XCTest
@testable import GeofenceMe

class GeofenceDetailsViewPresenterTests: XCTestCase {

    func defaultPresenter(model: GeofenceDetailsViewModel = GeofenceDetailsViewModel(),
                          locationService: LocationServiceProviding = LocationServiceMock(), geofenceService: GeofenceStorageProviding = GeoFenceStorageMock()) -> GeofenceDetailsViewPresenter {
        let presenter = GeofenceDetailsViewPresenter(viewModel: model,
                                                     locationService: locationService,
                                                     geofenceService: geofenceService)
        return presenter
    }
    
    func defaultLocationService() -> LocationServiceProviding {
        LocationServiceMock()
    }
    
    func defaultGeofenceStorage() -> GeofenceStorageProviding {
        GeoFenceStorageMock()
    }
    
    func defaultPresenterWithModel(model: GeofenceDetailsViewModel) -> GeofenceDetailsViewPresenter {
        return defaultPresenter(model: model,
                                locationService: defaultLocationService(),
                                geofenceService: defaultGeofenceStorage())
    }

    func testSetupDataGeneratesDefaultName() {
        let defaultName = DefaultNameGenerator.create()
        
        let presenter = defaultPresenter()
        presenter.setupData()
        
        XCTAssertTrue(presenter.name == defaultName, "Default name not generated after setup data is called.")
    }
    
    func testModelsAreDefinedCorrectly() {
        let models: [GeofenceDetailType] = [.Name, .Location, .OnEntry, .OnExit, .Radius]
        let presenter = defaultPresenter()
        XCTAssertTrue(models == presenter.details, "Models are not defined correctly.")
    }
    
    func testNameReturnedCorrect() {
        let testName = "Abu"
        var viewModel = GeofenceDetailsViewModel()
        viewModel.name = testName
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        
        XCTAssertTrue(presenter.name == testName, "Name returned is not empty string.")
    }
    
    func testRadiusUpdatedCorrectlyWhenSegmentValueIsSent() {
        let presenter = defaultPresenter()
        let delegateSpy = GeofenceDetailsPresenterDelegateTestSpy()
        presenter.delegate = delegateSpy
        
        presenter.updateSegmentIndex(index: 0)
        XCTAssertTrue(presenter.radius == 50.0, "Radius returned is not 50, when 0 is selected.")
        XCTAssertTrue(delegateSpy.updateFenceRegionCalled == 1, "Update fence region is not called correctly.")
        
        presenter.updateSegmentIndex(index: 1)
        XCTAssertTrue(presenter.radius == 100.0, "Radius returned is not 100, when 1 is selected.")
        XCTAssertTrue(delegateSpy.updateFenceRegionCalled == 2, "Update fence region is not called correctly.")
        
        presenter.updateSegmentIndex(index: 2)
        XCTAssertTrue(presenter.radius == 200.0, "Radius returned is not 200, when 2 is selected.")
        XCTAssertTrue(delegateSpy.updateFenceRegionCalled == 3, "Update fence region is not called correctly.")
    }
    
    func testOnEntryOnExitAreValidated() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = false
        viewModel.notifyOnExit = false
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        
        let status = presenter.validateData()
        XCTAssertTrue(status == .NoEntryExit, "No entry and exit is returned when either no entry or exit is selected.")
    }
    
    func testEmptyNameIsValidated() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = true
        viewModel.name = ""
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        
        let status = presenter.validateData()
        XCTAssertTrue(status == .NoName, "No name is validated.")
    }
    
    func testHighlightNameOnExitEntryAreShownWhenNoEntryNoExitNoNameInViewModel() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = false
        viewModel.notifyOnExit = false
        viewModel.name = ""
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        _ = presenter.validateData()
        
        XCTAssertTrue(presenter.highlightName == true, "Name is not highlighted even when no name is available.")
        XCTAssertTrue(presenter.highlightOnExit == true, "On Entry is not highlighted even when expected.")
        XCTAssertTrue(presenter.highlightOnEntry == true, "On Exit is not highlighted even when expected.")
    }
    
    func testHighlightNameIsShownWhenNoNameInViewModel() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = true
        viewModel.notifyOnExit = false
        viewModel.name = ""
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        _ = presenter.validateData()
        
        XCTAssertTrue(presenter.highlightName == true, "Name is not highlighted even when no name is available.")
        XCTAssertTrue(presenter.highlightOnExit == false, "On Entry is highlighted even when it should not.")
        XCTAssertTrue(presenter.highlightOnEntry == false, "On Exit is highlighted even when it should not.")
    }
    
    func testHighlightsAreNotEnabledWhenViewModelDataIsCorrect() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = false
        viewModel.notifyOnExit = true
        viewModel.name = "Abu"
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        _ = presenter.validateData()
        
        XCTAssertTrue(presenter.highlightName == false)
        XCTAssertTrue(presenter.highlightOnExit == false)
        XCTAssertTrue(presenter.highlightOnEntry == false)
    }
    
    func testEntryExitHighlightsAreResetWhenOnEntryIsSelected() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = false
        viewModel.notifyOnExit = false

        viewModel.shouldHighlightOnExit = true
        viewModel.shouldHighlightOnEntry = true
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        presenter.updateOnEntryMonitoring(value: true)
        
        XCTAssertTrue(presenter.highlightOnExit == false)
        XCTAssertTrue(presenter.highlightOnEntry == false)
    }
    
    func testEntryExitHighlightsAreResetWhenOnExitIsSelected() {
        var viewModel = GeofenceDetailsViewModel()
        viewModel.notifyOnEntry = false
        viewModel.notifyOnExit = false

        viewModel.shouldHighlightOnExit = true
        viewModel.shouldHighlightOnEntry = true
        
        let presenter = defaultPresenterWithModel(model: viewModel)
        presenter.updateOnExitMonitoring(value: true)
        
        XCTAssertTrue(presenter.highlightOnExit == false)
        XCTAssertTrue(presenter.highlightOnEntry == false)
    }

}
