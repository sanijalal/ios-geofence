//
//  GeofenceViewPresenter.swift
//  GeofenceMe
//
//  Created by Sani on 25/08/2021.
//

import Foundation

class GeofenceViewPresenter {
    private var viewModel: GeofenceViewModel
    private var geofenceService: GeofenceStorageProviding
    private var wifiService: WifiDetectorService
    
    init(viewModel: GeofenceViewModel = GeofenceViewModel(),
         geofenceService: GeofenceStorageProviding = GeofenceStorageService(),
         wifiService: WifiDetectorService = WifiDetectorService()) {
        self.viewModel = viewModel
        
        self.geofenceService = geofenceService
        self.viewModel.geofenceInfo = geofenceService.getGeofence()
        self.wifiService = wifiService
        self.wifiService.getSSIDName { name in
            self.viewModel.currentSSIDName = name
        }
    }
    
    var isInGeofence: Bool {
        guard let geofence = viewModel.geofenceInfo else {
            return false
        }
        
        return GeofenceCheckService.isGeofenceInLocation(geofence: geofence, latitude: viewModel.latitude, longitude: viewModel.longitude)
    }
    
    var isGeofenceAvailable: Bool {
        viewModel.geofenceInfo != nil
    }
    
    var geofenceLabelString: String {
        return viewModel.geofenceInfo == nil ? "No geofence configured." : "Geofence configured"
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
        return "Not connected to wifi"
    }
    
    
    
}
