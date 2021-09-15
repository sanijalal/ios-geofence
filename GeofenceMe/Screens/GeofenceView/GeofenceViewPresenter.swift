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
    
    func checkSSIDAssociation() {
        guard let geofence = viewModel.geofenceInfo else {
            return
        }

        if let currentSSID = wifiService.getWiFiSsid() {
            viewModel.currentSSIDName = currentSSID
            if (geofence.ssid == nil) {
                delegate?.promptToAssociateSSID(currentSSID)
            } else {
                delegate?.viewNeedsUpdate()
            }
        }
    }
    
    func updateCurrentGeofenceWithCurrentSSID() {
        guard var geofence = viewModel.geofenceInfo, let ssid = viewModel.currentSSIDName else {
            return
        }
        
        geofence.ssid = ssid
        geofenceService.deleteGeofence()
        geofenceService.saveGeofence(geofence)
        getData()
        delegate?.viewNeedsUpdate()
    }
    
    var isInGeofence: GeofenceLocationStatus {
        guard let geofence = viewModel.geofenceInfo else {
            return .Outside
        }
        
        if let ssid = geofence.ssid {
            if ssid == viewModel.currentSSIDName {
                return .InsideViaSSID
            }
        }
        
        let isLocationInside = GeofenceCheckService.isGeofenceInLocation(geofence: geofence, latitude: viewModel.latitude, longitude: viewModel.longitude)
        
        return isLocationInside ? .InsideViaLocation : .Outside
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
        switch isInGeofence {
        case .Outside:
            return "You are outside the geofence."
        case .InsideViaLocation:
            return "You are inside the geofence."
        case .InsideViaSSID:
            return "You are inside the geofence via wi-fi association."
        }
    }
    
    var geofenceColorName: String {
        isGeofenceAvailable ? "HasGeofenceColor" : "NoGeofenceColor"
    }
    
    var insideOutsideColorName: String {
        if (isGeofenceAvailable == false) { return "NoGeofenceColor" }
        switch isInGeofence {
        case .Outside:
            return "NoGeofenceColor"
        case .InsideViaLocation, .InsideViaSSID:
            return "HasGeofenceColor"
        }
    }
    
    var bottomButtonString: String {
        isGeofenceAvailable ? "Delete Geofence" : "Add Geofence"
    }
    
    var wifiLabelString: String {
        guard let ssid = viewModel.currentSSIDName else {return ""}
        return "You are connected to \(ssid)"
    }
    
    func bottomButtonPressed() {
        isGeofenceAvailable ? deleteGeofenceInfo() : coordinator?.presentAddGeofence()
    }
    
    func retrieveGeofenceInfo() {
        viewModel.geofenceInfo = geofenceService.getGeofence()
    }
    
    func deleteGeofenceInfo() {
        geofenceService.deleteGeofence()
        locationService.stopMonitorAllGeofences()
        getData()
        delegate?.viewNeedsUpdate()
    }
}

extension GeofenceViewPresenter: LocationServiceDelegate {
    func authorisationStatusUpdatedWith(_ status: CLAuthorizationStatus) {
        delegate?.viewNeedsUpdate()
    }
    
    func locationRetrieved(location: CLLocation) {
        viewModel.latitude = location.coordinate.latitude
        viewModel.longitude = location.coordinate.longitude
        delegate?.viewNeedsUpdate()
    }
}
