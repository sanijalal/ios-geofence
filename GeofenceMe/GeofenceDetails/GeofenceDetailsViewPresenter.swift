//
//  GeofenceDetailsViewPresenter.swift
//  GeofenceMe
//
//  Created by Abd Sani Abd Jalal on 06/09/2021.
//

import Foundation
import CoreLocation

class GeofenceDetailsViewPresenter {
    weak var coordinator: AppCoordinator?
    
    private var viewModel: GeofenceDetailsViewModel
    private let models: [GeofenceDetailType] = [.Name, .Location, .OnEntry, .OnExit, .Radius]
    weak var delegate: GeofenceDetailsPresenterDelegate?
    private var locationService: LocationServiceProviding
    
    
    init(viewModel: GeofenceDetailsViewModel = GeofenceDetailsViewModel(), locationService: LocationServiceProvider = LocationServiceProvider()) {
        self.locationService = locationService
        self.viewModel = viewModel
        self.locationService.delegate = self
    }
    
    var details: [GeofenceDetailType] {
        self.models
    }
    
    var name: String {
        viewModel.name
    }
    
    var notifyOnEntry: Bool {
        viewModel.notifyOnEntry
    }
    
    var notifyOnExit: Bool {
        viewModel.notifyOnExit
    }
    
    var radiusSegmentIndex: Int {
        if viewModel.radius == 50 {
            return 0
        } else if viewModel.radius == 100 {
            return 1
        } else if viewModel.radius == 200 {
            return 2
        } else {
            return 0
        }
    }
    
    var radius: Double {
        viewModel.radius
    }
    
    var mapRange: Double {
        var extendRadius = 100.0
        if viewModel.radius == 200 {
            extendRadius = 250.0
        }
        return viewModel.radius + extendRadius
    }
    
    func updateSegmentIndex(index: Int) {
        if (index == 0) {
            viewModel.radius = 50
        } else if (index == 1) {
            viewModel.radius = 100
        } else if (index == 2) {
            viewModel.radius = 200
        }
        
        let coordinate = CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
        delegate?.updateFenceRegion(location: coordinate, radius: viewModel.radius)

        delegate?.updateZoomAtLocation(location: coordinate,
                                       zoom: mapRange)
    }
    
    func updateOnEntryMonitoring(value: Bool) {
        viewModel.notifyOnEntry = value
    }
    
    func updateOnExitMonitoring(value: Bool) {
        viewModel.notifyOnExit = value
    }
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: viewModel.latitude, longitude: viewModel.longitude)
    }
    
    func startLocationUpdate() {
        locationService.requestLocationPermission()
        locationService.startLocationDetection()
    }
    
    func changeName(_ name: String?) {
        if let name = name {
            viewModel.name = name
        } else {
            viewModel.name = ""
        }
    }
    
    func nameFieldSelected() {
        coordinator?.pushDetail(label: "Name", value: viewModel.name)
    }
}

extension GeofenceDetailsViewPresenter: LocationServiceDelegate {
    func authorisationStatusUpdatedWith(_ status: CLAuthorizationStatus) {
        
    }
    
    func locationRetrieved(location: CLLocation) {
        viewModel.latitude = location.coordinate.latitude
        viewModel.longitude = location.coordinate.longitude
        delegate?.locationUpdated(location: location)
    }
}
