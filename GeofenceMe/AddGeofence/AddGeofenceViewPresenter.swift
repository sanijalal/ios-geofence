//
//  AddGeofenceViewPresenter.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation
import MapKit

class AddGeofenceViewPresenter {
    var latitude: Double {
        viewModel.latitude
    }
    
    var longitude: Double {
        viewModel.longitude
    }
    
    var currentFenceRange: CLLocationDistance {
        viewModel.currentFenceRange
    }
    
    var currentMapRange: CLLocationDistance {
        viewModel.currentFenceRange + 250
    }
    
    var viewModel: AddGeofenceViewModel
    weak var delegate: AddGeofenceViewPresenterDelegate?
    var geofenceService: GeofenceStorageProviding
    private var locationService: LocationServiceProviding
    weak var coordinator: AppCoordinator?
    
    init (geofenceService: GeofenceStorageProviding = GeofenceStorageService(),
          viewModel: AddGeofenceViewModel = AddGeofenceViewModel(),
          locationService: LocationServiceProviding = LocationServiceProvider()) {
        self.geofenceService = geofenceService
        self.viewModel = viewModel
        self.locationService = locationService
        self.locationService.delegate = self
    }
    
    func segmentSelected(index: Int) {
        viewModel.currentFenceRange = CLLocationDistance((index + 1) * 50)
        delegate?.fenceRangeChanged()
    }
    
    func startLocationUpdate() {
        locationService.requestLocationPermission()
        locationService.startLocationDetection()
    }
    
    func stopLocationUpdate() {
        locationService.stopLocationDetection()
    }
    
    func didRetrieveLocation() {
        delegate?.locationChanged()
    }
    
    func saveGeofence() {
        let geofence = GeofenceInfo(latitude: latitude, longitude: longitude, radius: Int(currentFenceRange))
        geofenceService.saveGeofence(geofence)
        locationService.startMonitoring(geofence: geofence)
    }
    
    func saveButtonPressed() {
        saveGeofence()
        coordinator?.dismissAddGeofence()
    }
}

extension AddGeofenceViewPresenter: LocationServiceDelegate {
    func authorisationStatusUpdated(_ with: CLAuthorizationStatus) {
        
    }
    
    func locationRetrieved(location: CLLocation) {
        viewModel.latitude = location.coordinate.latitude
        viewModel.longitude = location.coordinate.longitude
        didRetrieveLocation()
    }
    
    
}
