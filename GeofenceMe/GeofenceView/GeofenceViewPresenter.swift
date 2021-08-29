//
//  GeofenceViewPresenter.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation
import CoreLocation

class GeofenceViewPresenter {
    var delegate: GeofenceViewPresenterDelegate?
    weak var coordinator: AppCoordinator?
    
    private var viewModel: GeofenceViewModel
    private var geofenceService: GeofenceStorageProviding
    private var wifiService: WifiDetectorService
    private var locationService: LocationServiceProviding
    
    init(viewModel: GeofenceViewModel = GeofenceViewModel(),
         geofenceService: GeofenceStorageProviding = GeofenceStorageService(),
         wifiService: WifiDetectorService = WifiDetectorService(),
         locationService: LocationServiceProviding = LocationServiceProvider()) {
        self.viewModel = viewModel
        
        self.geofenceService = geofenceService
        self.locationService = locationService
        
        self.wifiService = wifiService
        self.wifiService.getSSIDName { name in
            self.viewModel.currentSSIDName = name
        }
        
        self.locationService.delegate = self
    }
    
    func getData() {
        startLocationDetection()
        retrieveGeofenceInfo()
    }
    
    func startLocationDetection() {
        locationService.startLocationDetection()
    }
    
    func stopLocationDetection() {
        locationService.stopLocationDetection()
    }
    
    var isInGeofence: Bool {
        guard let geofence = viewModel.geofenceInfo else {
            return false
        }
        
        return GeofenceCheckService.isGeofenceInLocation(geofence: geofence, latitude: viewModel.latitude, longitude: viewModel.longitude)
    }
    
    var geofenceInfo: GeofenceInfo? {
        viewModel.geofenceInfo
    }
    
    var isGeofenceAvailable: Bool {
        viewModel.geofenceInfo != nil
    }
    
    var latitude: Double {
        viewModel.latitude
    }
    
    var longitude: Double {
        viewModel.longitude
    }
    
    var geofenceLabelString: String {
        viewModel.geofenceInfo == nil ? "No geofence configured." : "Geofence configured"
    }
    
    var insideOutsideLabelString: String {
        if (isGeofenceAvailable == false) { return "" }
        
        if (isInGeofence) {
            return "You are inside the geofence."
        } else {
            return "You are outside the geofence."
        }
    }
    
    var wifiLabelString: String {
        "Not connected to wifi"
    }
    
    var showBottomButton: Bool {
        !isGeofenceAvailable
    }
    
    func bottomButtonPressed() {
        coordinator?.presentAddGeofence()
    }
    
    func retrieveGeofenceInfo() {
        viewModel.geofenceInfo = geofenceService.getGeofence()
    }
}

extension GeofenceViewPresenter: LocationServiceDelegate {
    func authorisationStatusUpdated(_ with: CLAuthorizationStatus) {
        delegate?.viewNeedsUpdate()
    }
    
    func locationRetrieved(location: CLLocation) {
        viewModel.latitude = location.coordinate.latitude
        viewModel.longitude = location.coordinate.longitude
        delegate?.viewNeedsUpdate()
    }
    
    
}
