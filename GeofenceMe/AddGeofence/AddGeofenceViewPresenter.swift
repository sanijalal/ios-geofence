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
    
    init (geofenceService: GeofenceStorageProviding = GeofenceStorageService(), viewModel: AddGeofenceViewModel = AddGeofenceViewModel()) {
        self.geofenceService = geofenceService
        self.viewModel = viewModel
    }
    
    func segmentSelected(index: Int) {
        viewModel.currentFenceRange = CLLocationDistance((index + 1) * 50)
        delegate?.fenceRangeChanged()
    }
    
    func didRetrieveLocation() {
        delegate?.locationChanged()
    }
    
    func saveGeofence() {
        let geofence = GeofenceInfo(latitude: latitude, longitude: longitude, radius: Int(currentFenceRange))
        geofenceService.saveGeofence(geofence)
    }
}
